import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'mi_base_de_datos.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE usuarios(id INTEGER PRIMARY KEY, nombre TEXT)',
        );
      },
      version: 1,
    );
  }

  // Métodos CRUD
  Future<void> insertUsuario(Map<String, dynamic> usuario) async {
    final db = await database;
    await db.insert(
      'usuarios',
      usuario,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getUsuarios() async {
    final db = await database;
    return await db.query('usuarios');
  }

  Future<void> updateUsuario(Map<String, dynamic> usuario) async {
    final db = await database;
    await db.update(
      'usuarios',
      usuario,
      where: 'id = ?',
      whereArgs: [usuario['id']],
    );
  }

  Future<void> deleteUsuario(int id) async {
    final db = await database;
    await db.delete(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
