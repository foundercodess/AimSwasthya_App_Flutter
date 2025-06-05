// local_db/image_db.dart
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "app_database.db";
  static const _databaseVersion = 1;
  static const table = "static_icon";

  static const columnId = "id";
  static const columnName = "name";
  static const columnImagePath = "image_path";


  static const String tableDoctor = 'doctor';
  static const String colId = 'id';
  static const String colPhoto = 'photo_path';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade,);
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnImagePath TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $tableDoctor (
          $colId INTEGER PRIMARY KEY, 
          $colPhoto TEXT
        )
      ''');
    }
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> fetchAll() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> insertDoctor(int id, String photoPath) async {
    Database db = await database;
    return await db.insert(
      tableDoctor,
      {colId: id, colPhoto: photoPath},
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if ID already exists
    );
  }

  Future<List<Map<String, dynamic>>> getDoctors() async {
    Database db = await database;
    return await db.query(tableDoctor);
  }

  Future<int> clearDoctorTable() async {
    Database db = await database;
    return await db.delete(tableDoctor);
  }
}
