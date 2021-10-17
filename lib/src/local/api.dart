import 'package:flutter/foundation.dart';
import 'package:gagaku/src/local/settings.dart';
import 'package:gagaku/src/local/types.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class LocalDatabaseModel extends ChangeNotifier {
  LocalDatabaseSettings _settings = LocalDatabaseSettings();

  Database? _db;

  LocalDatabaseSettings get settings => _settings;

  Future<Database> get database async {
    if (_db == null) {
      _db = await initDatabase();
    }

    return _db!;
  }

  LocalDatabaseModel() : super() {
    init();
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getApplicationSupportDirectory();
    String dbpath = p.join(databasesPath.path, 'gagaku.db');

    var database = await openDatabase(dbpath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE manga(id TEXT PRIMARY KEY, name TEXT UNIQUE NOT NULL, path TEXT NOT NULL, read TEXT)');
    });

    return database;
  }

  void init() async {
    _settings = await LocalDatabaseSettings.load();
  }

  Future<void> setSettings(LocalDatabaseSettings settings) async {
    _settings = settings;

    // Save settings
    await _settings.save();

    notifyListeners();
  }

  /// Insert a new [manga] to local library db
  Future<void> insertManga(LocalManga manga) async {
    // Get a reference to the database.
    final db = await database;

    await db.insert(
      'manga',
      manga.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    notifyListeners();
  }

  /// Retrieve all mangas in the local library db
  Future<List<LocalManga>> getAllMangas() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('manga');

    return List.generate(maps.length, (i) {
      return LocalManga(
        id: maps[i]['id'],
        name: maps[i]['name'],
        path: maps[i]['path'],
        readChapters: List.castFrom(maps[i]['read']),
      );
    });
  }

  /// Update a manga entry in the local library db
  Future<void> updateManga(LocalManga manga) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'manga',
      manga.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [manga.id],
    );

    notifyListeners();
  }
}
