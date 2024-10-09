import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:food_recipes/src/models/platillo_model.dart';
import 'package:food_recipes/src/models/ingredientes_model.dart';

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
      version: 3,
      onCreate: (db, version) {

        db.execute('''
          CREATE TABLE platillos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            tiempoPreparacion INTEGER,
            tipoComida TEXT,
            pasos TEXT,
            favorito INTEGER DEFAULT 0
          )
        ''');

        // Crear la tabla ingredientes, relacionada con platillos
        db.execute('''
          CREATE TABLE ingredientes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            cantidad TEXT,
            platillo_id INTEGER,
            FOREIGN KEY(platillo_id) REFERENCES platillos(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  Future<int> insertPlatillo(Platillo platillo) async {
    final db = await database;
    return await db.insert(
      'platillos',
      platillo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertIngrediente(Ingrediente ingrediente) async {
    final db = await database;
    await db.insert(
      'ingredientes',
      ingrediente.toMap(),
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

  Future<List<Ingrediente>> getIngredientes(int platilloId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'ingredientes',
      where: 'platillo_id = ?',
      whereArgs: [platilloId],
    );

    return List.generate(maps.length, (i) {
      return Ingrediente.fromMap(maps[i]);
    });
  }

  Future<Platillo?> getPlatilloById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'platillos',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Platillo.fromMap(maps.first);
    }
    return null; // Retorna null si no se encuentra el platillo
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

  Future<List<Platillo>> getFavoritos() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'platillos',
    where: 'favorito = ?',
    whereArgs: [1], // Solo obtener los favoritos
  );

  return List.generate(maps.length, (i) {
    return Platillo.fromMap(maps[i]);
  });
}


Future<void> toggleFavorito(int id) async {
  final db = await database;
  
  // Primero obtenemos el platillo actual
  Platillo? platillo = await getPlatilloById(id);
  
  if (platillo != null) {
    // Cambiamos el estado de 'favorito'
    bool nuevoEstado = !platillo.favorito;
    
    // Actualizamos el platillo en la base de datos
    await db.update(
      'platillos',
      platillo.copyWith(favorito: nuevoEstado).toMap(),
      where: 'id = ?',
      whereArgs: [platillo.id],
    );
  }
}

}
