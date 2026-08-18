package r52.gagaku

import android.app.Activity
import android.content.Intent
import android.database.ContentObserver
import android.database.Cursor
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import android.provider.DocumentsContract
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.FileNotFoundException
import java.util.concurrent.CountDownLatch
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit

class MainActivity : FlutterFragmentActivity() {
    private val ioExecutor: ExecutorService = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())
    private var pendingTreeResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME,
        ).setMethodCallHandler(::handleMethodCall)
    }

    private fun handleMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "pickTree" -> pickTree(result)
            "checkAccess" -> runIo(result) {
                tree(call).also(::requirePersistedAccess)
                null
            }
            "list" -> runIo(result) {
                val treeUri = tree(call)
                requirePersistedAccess(treeUri)
                val prefix = call.argument<String>("prefix") ?: ""
                validatePrefix(prefix)
                buildList {
                    listChildren(treeUri, rootDocument(treeUri), emptyList(), prefix, this)
                }.sortedBy { it["key"] as String }
            }
            "read" -> runIo(result) {
                val treeUri = tree(call)
                requirePersistedAccess(treeUri)
                val key = requiredKey(call)
                val document = resolve(treeUri, keySegments(key))
                    ?: throw SafFailure("NOT_FOUND", "Sync object was not found: $key")
                if (document.isDirectory) {
                    throw SafFailure("WEAK_PROVIDER", "Sync object is not a regular document: $key")
                }
                contentResolver.openInputStream(document.uri)?.use { it.readBytes() }
                    ?: throw SafFailure("IO_ERROR", "Unable to open sync object: $key")
            }
            "create" -> runIo(result) {
                val treeUri = tree(call)
                requirePersistedAccess(treeUri)
                val key = requiredKey(call)
                val bytes = call.argument<ByteArray>("bytes")
                    ?: throw SafFailure("INVALID_ARGUMENT", "Missing object contents")
                createObject(treeUri, key, bytes)
                null
            }
            "delete" -> runIo(result) {
                val treeUri = tree(call)
                requirePersistedAccess(treeUri)
                val key = requiredKey(call)
                val document = resolve(treeUri, keySegments(key)) ?: return@runIo null
                if (document.isDirectory) {
                    throw SafFailure("WEAK_PROVIDER", "Sync object is not a regular document: $key")
                }
                if (!DocumentsContract.deleteDocument(contentResolver, document.uri)) {
                    throw SafFailure("IO_ERROR", "Document provider refused to delete: $key")
                }
                null
            }
            else -> result.notImplemented()
        }
    }

    private fun pickTree(result: MethodChannel.Result) {
        if (pendingTreeResult != null) {
            result.error("BUSY", "A document-tree picker is already open", null)
            return
        }
        pendingTreeResult = result
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).addFlags(
            Intent.FLAG_GRANT_READ_URI_PERMISSION or
                Intent.FLAG_GRANT_WRITE_URI_PERMISSION or
                Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION or
                Intent.FLAG_GRANT_PREFIX_URI_PERMISSION,
        )
        startActivityForResult(intent, TREE_REQUEST_CODE)
    }

    @Deprecated("The system document-tree picker still reports through this API")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode != TREE_REQUEST_CODE) {
            super.onActivityResult(requestCode, resultCode, data)
            return
        }
        val result = pendingTreeResult ?: return
        pendingTreeResult = null
        val treeUri = data?.data
        if (resultCode != Activity.RESULT_OK || treeUri == null) {
            result.success(null)
            return
        }
        try {
            val flags = data.flags and
                (Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
            if (flags and Intent.FLAG_GRANT_READ_URI_PERMISSION == 0 ||
                flags and Intent.FLAG_GRANT_WRITE_URI_PERMISSION == 0
            ) {
                throw SafFailure(
                    "PERMISSION_DENIED",
                    "The selected provider did not grant read and write access",
                )
            }
            contentResolver.takePersistableUriPermission(treeUri, flags)
            requirePersistedAccess(treeUri)
            result.success(
                mapOf(
                    "uri" to treeUri.toString(),
                    "displayName" to rootDocument(treeUri).name,
                ),
            )
        } catch (error: Throwable) {
            reportError(result, error)
        }
    }

    override fun onDestroy() {
        pendingTreeResult?.error("CANCELLED", "Document-tree picker was closed", null)
        pendingTreeResult = null
        ioExecutor.shutdownNow()
        super.onDestroy()
    }

    private fun runIo(result: MethodChannel.Result, operation: () -> Any?) {
        ioExecutor.execute {
            try {
                val value = operation()
                mainHandler.post { result.success(value) }
            } catch (error: Throwable) {
                mainHandler.post { reportError(result, error) }
            }
        }
    }

    private fun reportError(result: MethodChannel.Result, error: Throwable) {
        when (error) {
            is SafFailure -> result.error(error.code, error.message, null)
            is SecurityException -> result.error(
                "PERMISSION_DENIED",
                error.message ?: "Access to the selected document tree was revoked",
                null,
            )
            is FileNotFoundException -> result.error(
                "NOT_FOUND",
                error.message ?: "The selected document no longer exists",
                null,
            )
            else -> result.error(
                "IO_ERROR",
                error.message ?: "Document provider operation failed",
                null,
            )
        }
    }

    private fun tree(call: MethodCall): Uri {
        val value = call.argument<String>("treeUri")
            ?: throw SafFailure("INVALID_ARGUMENT", "Missing document-tree URI")
        val uri = Uri.parse(value)
        if (uri.scheme != "content" || !DocumentsContract.isTreeUri(uri)) {
            throw SafFailure("INVALID_ARGUMENT", "Invalid document-tree URI")
        }
        return uri
    }

    private fun requirePersistedAccess(treeUri: Uri) {
        val permission = contentResolver.persistedUriPermissions.firstOrNull {
            it.uri == treeUri && it.isReadPermission && it.isWritePermission
        }
        if (permission == null) {
            throw SafFailure(
                "PERMISSION_DENIED",
                "Access to the selected document tree has been revoked",
            )
        }
    }

    private fun rootDocument(treeUri: Uri): SafDocument {
        val documentId = DocumentsContract.getTreeDocumentId(treeUri)
        val uri = DocumentsContract.buildDocumentUriUsingTree(treeUri, documentId)
        return queryDocument(uri)
            ?: throw SafFailure("NOT_FOUND", "The selected document tree no longer exists")
    }

    private fun resolve(treeUri: Uri, segments: List<String>): SafDocument? {
        var current = rootDocument(treeUri)
        for ((index, segment) in segments.withIndex()) {
            if (!current.isDirectory) {
                throw SafFailure("WEAK_PROVIDER", "A sync path component is not a directory")
            }
            val child = findChild(treeUri, current, segment) ?: return null
            if (index < segments.lastIndex && !child.isDirectory) {
                throw SafFailure("WEAK_PROVIDER", "A sync path component is not a directory")
            }
            current = child
        }
        return current
    }

    private fun findChild(
        treeUri: Uri,
        parent: SafDocument,
        name: String,
    ): SafDocument? {
        val matches = queryChildren(treeUri, parent).filter { it.name == name }
        if (matches.size > 1) {
            throw SafFailure(
                "WEAK_PROVIDER",
                "The document provider returned duplicate names for $name",
            )
        }
        return matches.singleOrNull()
    }

    private fun queryChildren(treeUri: Uri, parent: SafDocument): List<SafDocument> {
        val childrenUri = DocumentsContract.buildChildDocumentsUriUsingTree(
            treeUri,
            parent.documentId,
        )
        val deadline = SystemClock.elapsedRealtime() + DIRECTORY_LOADING_TIMEOUT_MS
        while (true) {
            val changed = CountDownLatch(1)
            val observer = object : ContentObserver(null) {
                override fun onChange(selfChange: Boolean) {
                    changed.countDown()
                }
            }
            contentResolver.registerContentObserver(childrenUri, false, observer)
            try {
                var loading = false
                val documents = contentResolver.query(
                    childrenUri,
                    PROJECTION,
                    null,
                    null,
                    null,
                )?.use { cursor ->
                    loading = cursor.extras.getBoolean(DocumentsContract.EXTRA_LOADING, false)
                    buildList<SafDocument> {
                        while (cursor.moveToNext()) add(documentFromCursor(treeUri, cursor))
                    }
                } ?: throw SafFailure("IO_ERROR", "Unable to list the selected document tree")
                if (!loading) return documents

                val remaining = deadline - SystemClock.elapsedRealtime()
                if (remaining <= 0) {
                    throw SafFailure(
                        "PROVIDER_LOADING",
                        "The document provider is still loading this directory",
                    )
                }
                changed.await(
                    minOf(remaining, DIRECTORY_LOADING_POLL_MS),
                    TimeUnit.MILLISECONDS,
                )
            } finally {
                contentResolver.unregisterContentObserver(observer)
            }
        }
    }

    private fun queryDocument(uri: Uri): SafDocument? =
        contentResolver.query(uri, PROJECTION, null, null, null)?.use { cursor ->
            if (cursor.moveToFirst()) documentFromCursor(uri, cursor) else null
        }

    private fun documentFromCursor(treeUri: Uri, cursor: Cursor): SafDocument {
        val documentId = cursor.getString(0)
        val uri = if (DocumentsContract.isDocumentUri(this, treeUri)) {
            treeUri
        } else {
            DocumentsContract.buildDocumentUriUsingTree(treeUri, documentId)
        }
        return SafDocument(
            uri = uri,
            documentId = documentId,
            name = cursor.getString(1),
            mimeType = cursor.getString(2),
            flags = cursor.getInt(3),
            size = if (cursor.isNull(4)) 0L else cursor.getLong(4),
        )
    }

    private fun listChildren(
        treeUri: Uri,
        parent: SafDocument,
        parentSegments: List<String>,
        prefix: String,
        output: MutableList<Map<String, Any>>,
    ) {
        for (child in queryChildren(treeUri, parent)) {
            if (!isSafeSegment(child.name)) continue
            val segments = parentSegments + child.name
            val key = segments.joinToString("/")
            if (child.isDirectory) {
                listChildren(treeUri, child, segments, prefix, output)
            } else if (key.startsWith(prefix)) {
                output += mapOf("key" to key, "length" to child.size)
            }
        }
    }

    private fun createObject(treeUri: Uri, key: String, bytes: ByteArray) {
        val segments = keySegments(key)
        var parent = rootDocument(treeUri)
        for (segment in segments.dropLast(1)) {
            var child = findChild(treeUri, parent, segment)
            if (child == null) {
                requireCreateSupport(parent)
                val created = DocumentsContract.createDocument(
                    contentResolver,
                    parent.uri,
                    DocumentsContract.Document.MIME_TYPE_DIR,
                    segment,
                ) ?: throw SafFailure("IO_ERROR", "Unable to create sync directory: $segment")
                verifyExactName(created, segment)
                child = awaitVisibleChild(treeUri, parent, segment)
                    ?: throw SafFailure(
                        "WEAK_PROVIDER",
                        "Created sync directory did not become visible: $segment",
                    )
            }
            if (!child.isDirectory) {
                throw SafFailure("WEAK_PROVIDER", "A sync path component is not a directory")
            }
            parent = child
        }

        val name = segments.last()
        if (findChild(treeUri, parent, name) != null) {
            throw SafFailure("ALREADY_EXISTS", "Sync object already exists: $key")
        }
        requireCreateSupport(parent)
        val created = DocumentsContract.createDocument(
            contentResolver,
            parent.uri,
            "application/octet-stream",
            name,
        ) ?: throw SafFailure("IO_ERROR", "Unable to create sync object: $key")
        try {
            verifyExactName(created, name)
            contentResolver.openOutputStream(created, "w")?.use { stream ->
                stream.write(bytes)
                stream.flush()
            } ?: throw SafFailure("IO_ERROR", "Unable to write sync object: $key")
            if (awaitVisibleChild(treeUri, parent, name) == null) {
                throw SafFailure(
                    "WEAK_PROVIDER",
                    "Created sync object did not become visible: $key",
                )
            }
        } catch (error: Throwable) {
            try {
                DocumentsContract.deleteDocument(contentResolver, created)
            } catch (_: Throwable) {
                // Repository validation will reject any incomplete object.
            }
            throw error
        }
    }

    private fun requireCreateSupport(parent: SafDocument) {
        if (!parent.isDirectory ||
            parent.flags and DocumentsContract.Document.FLAG_DIR_SUPPORTS_CREATE == 0
        ) {
            throw SafFailure(
                "WEAK_PROVIDER",
                "The selected document provider does not support creating objects",
            )
        }
    }

    private fun verifyExactName(uri: Uri, expected: String) {
        val actual = queryDocument(uri)?.name
        if (actual != expected) {
            throw SafFailure(
                "WEAK_PROVIDER",
                "The document provider renamed '$expected' to '${actual ?: "unknown"}'",
            )
        }
    }

    private fun awaitVisibleChild(
        treeUri: Uri,
        parent: SafDocument,
        name: String,
    ): SafDocument? {
        repeat(VISIBILITY_ATTEMPTS) { attempt ->
            findChild(treeUri, parent, name)?.let { return it }
            if (attempt < VISIBILITY_ATTEMPTS - 1) Thread.sleep(VISIBILITY_DELAY_MS)
        }
        return null
    }

    private fun requiredKey(call: MethodCall): String {
        val key = call.argument<String>("key")
            ?: throw SafFailure("INVALID_ARGUMENT", "Missing sync object key")
        keySegments(key)
        return key
    }

    private fun keySegments(key: String): List<String> {
        if (key.isEmpty() || key.endsWith('/')) {
            throw SafFailure("INVALID_ARGUMENT", "Sync key must identify an object")
        }
        validatePrefix(key)
        return key.split('/')
    }

    private fun validatePrefix(prefix: String) {
        if (prefix.startsWith('/') || prefix.contains('\\') || prefix.contains('\u0000') ||
            prefix.contains(':')
        ) {
            throw SafFailure("INVALID_ARGUMENT", "Unsafe sync object key")
        }
        val value = prefix.removeSuffix("/")
        if (value.isNotEmpty() && value.split('/').any { !isSafeSegment(it) }) {
            throw SafFailure("INVALID_ARGUMENT", "Unsafe sync object key")
        }
    }

    private fun isSafeSegment(segment: String): Boolean =
        segment.isNotEmpty() && segment != "." && segment != ".."

    private data class SafDocument(
        val uri: Uri,
        val documentId: String,
        val name: String,
        val mimeType: String,
        val flags: Int,
        val size: Long,
    ) {
        val isDirectory: Boolean
            get() = mimeType == DocumentsContract.Document.MIME_TYPE_DIR
    }

    private class SafFailure(val code: String, message: String) : Exception(message)

    companion object {
        private const val CHANNEL_NAME = "r52.gagaku/saf_sync"
        private const val TREE_REQUEST_CODE = 7306
        private const val VISIBILITY_ATTEMPTS = 20
        private const val VISIBILITY_DELAY_MS = 250L
        private const val DIRECTORY_LOADING_TIMEOUT_MS = 5_000L
        private const val DIRECTORY_LOADING_POLL_MS = 500L
        private val PROJECTION = arrayOf(
            DocumentsContract.Document.COLUMN_DOCUMENT_ID,
            DocumentsContract.Document.COLUMN_DISPLAY_NAME,
            DocumentsContract.Document.COLUMN_MIME_TYPE,
            DocumentsContract.Document.COLUMN_FLAGS,
            DocumentsContract.Document.COLUMN_SIZE,
        )
    }
}
