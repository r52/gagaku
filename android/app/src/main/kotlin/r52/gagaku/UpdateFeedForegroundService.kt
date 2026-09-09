package r52.gagaku

import android.annotation.SuppressLint
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.os.PowerManager

class UpdateFeedForegroundService : Service() {
    private var wakeLock: PowerManager.WakeLock? = null

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_START -> {
                val notificationText = intent.getStringExtra(EXTRA_NOTIFICATION_TEXT)
                if (notificationText.isNullOrBlank()) {
                    stopAndRelease(startId)
                    return START_NOT_STICKY
                }
                try {
                    startInForeground(notificationText)
                    acquireWakeLock()
                } catch (error: Throwable) {
                    stopAndRelease(startId)
                    throw error
                }
            }
            ACTION_STOP -> stopAndRelease(startId)
            else -> stopAndRelease(startId)
        }
        return START_NOT_STICKY
    }

    override fun onTaskRemoved(rootIntent: Intent?) {
        stopAndRelease()
        super.onTaskRemoved(rootIntent)
    }

    override fun onDestroy() {
        releaseResources()
        super.onDestroy()
    }

    override fun onTimeout(startId: Int, fgsType: Int) {
        stopAndRelease(startId)
    }

    private fun startInForeground(notificationText: String) {
        createNotificationChannel()
        val notification = buildNotification(notificationText)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            startForeground(
                NOTIFICATION_ID,
                notification,
                ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC,
            )
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
            return
        }
        val appLabel = applicationInfo.loadLabel(packageManager).toString()
        val channel = NotificationChannel(
            NOTIFICATION_CHANNEL_ID,
            appLabel,
            NotificationManager.IMPORTANCE_LOW,
        ).apply {
            setShowBadge(false)
        }
        getSystemService(NotificationManager::class.java).createNotificationChannel(channel)
    }

    private fun buildNotification(notificationText: String): Notification {
        val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
        val pendingIntent = launchIntent?.let {
            PendingIntent.getActivity(
                this,
                0,
                it,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            )
        }
        val builder = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Notification.Builder(this, NOTIFICATION_CHANNEL_ID)
        } else {
            @Suppress("DEPRECATION")
            Notification.Builder(this).setPriority(Notification.PRIORITY_LOW)
        }
        return builder
            .setContentTitle(applicationInfo.loadLabel(packageManager))
            .setContentText(notificationText)
            .setSmallIcon(R.drawable.ic_update_feed)
            .setContentIntent(pendingIntent)
            .setCategory(Notification.CATEGORY_SERVICE)
            .setOngoing(true)
            .setOnlyAlertOnce(true)
            .build()
    }

    @SuppressLint("WakelockTimeout")
    private fun acquireWakeLock() {
        val current = wakeLock
        if (current?.isHeld == true) {
            return
        }
        wakeLock = (getSystemService(Context.POWER_SERVICE) as PowerManager)
            .newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, WAKE_LOCK_TAG)
            .apply {
                setReferenceCounted(false)
                acquire()
            }
    }

    private fun stopAndRelease(startId: Int? = null) {
        releaseResources()
        if (startId == null) {
            stopSelf()
        } else {
            stopSelf(startId)
        }
    }

    private fun releaseResources() {
        wakeLock?.let { lock ->
            if (lock.isHeld) {
                lock.release()
            }
        }
        wakeLock = null
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            stopForeground(STOP_FOREGROUND_REMOVE)
        } else {
            @Suppress("DEPRECATION")
            stopForeground(true)
        }
    }

    companion object {
        private const val ACTION_START = "r52.gagaku.action.START_UPDATE_FEED"
        private const val ACTION_STOP = "r52.gagaku.action.STOP_UPDATE_FEED"
        private const val EXTRA_NOTIFICATION_TEXT = "notificationText"
        private const val NOTIFICATION_CHANNEL_ID = "gagaku_update_feed_execution"
        private const val NOTIFICATION_ID = 1
        private const val WAKE_LOCK_TAG = "Gagaku:UpdateFeed"

        fun start(context: Context, notificationText: String) {
            val intent = Intent(context, UpdateFeedForegroundService::class.java).apply {
                action = ACTION_START
                putExtra(EXTRA_NOTIFICATION_TEXT, notificationText)
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }

        fun stop(context: Context) {
            context.stopService(Intent(context, UpdateFeedForegroundService::class.java))
        }
    }
}
