import 'dart:async';
import 'dart:developer';
import 'dart:io' as io;

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tutorials_project/sqflite_crud/models/notes_model.dart';

class DBHelper {
  static Database? _db;

  static String dbName = 'notes.db';
  static String dbTable = 'Notes';
  static int dbVersion = 1;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentaryDirectory = await getApplicationCacheDirectory();
    String path = join(documentaryDirectory.path, dbName);
    log("Database path: $path"); // Add this line
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  ///Initialize database
  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $dbTable (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER NOT NULL, address TEXT NOT NULL)',
    );
  }

  ///Create Record
  Future<NotesModel> insertRecord(NotesModel notes) async {
    var dbClient = await db;
    await dbClient!.insert(dbTable, notes.toMap());
    return notes;
  }

  ///Fetch Record
  Future<List<NotesModel>> fetchRecords() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query(dbTable);

    return queryResult.map((e) => NotesModel.fromMap(e)).toList();
  }

  ///Delete Record
  Future<int> deleteRecords(int id) async {
    var dbClient = await db;
    return dbClient!.delete(dbTable, where: 'id=?', whereArgs: [id]);
  }

  ///Update Record
  Future<int> updateRecords(NotesModel mdl) async {
    var dbClient = await db;
    return dbClient!.update(
      dbTable,
      mdl.toMap(),
      where: 'id=?',
      whereArgs: [mdl.id],
    );
  }
}
