import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:food_recipes/src/models/platillo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'platillos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE platillos(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT)',
        );
      },
    );
  }

  Future<void> insertPlatillo(Platillo platillo) async {
    final db = await database;
    await db.insert(
      'platillos',
      platillo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Platillo>> getPlatillos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('platillos');

    return List.generate(maps.length, (i) {
      return Platillo.fromMap(maps[i]);
    });
  }

  Future<void> updatePlatillo(Platillo platillo) async {
    final db = await database;
    await db.update(
      'platillos',
      platillo.toMap(),
      where: 'id = ?',
      whereArgs: [platillo.id],
    );
  }

  Future<void> deletePlatillo(int id) async {
    final db = await database;
    await db.delete(
      'platillos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
