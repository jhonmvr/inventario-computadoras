import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/computadora.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDB();
    return _database!;
  }

  Future<Database> initializeDB() async {
    String path = join(await getDatabasesPath(), 'computadoras.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE computadoras(id INTEGER PRIMARY KEY AUTOINCREMENT, procesador TEXT, discoDuro TEXT, ram TEXT)",
        );
        await populateDatabase(db);
      },
    );
  }

  Future<void> populateDatabase(Database db) async {
    List<Map<String, dynamic>> data = await db.query('computadoras');
    if (data.isEmpty) {
      await db.insert(
          'computadoras',
          Computadora(procesador: 'Intel i5', discoDuro: '500GB', ram: '8GB')
              .toMap());
      await db.insert(
          'computadoras',
          Computadora(procesador: 'AMD Ryzen 5', discoDuro: '1TB', ram: '16GB')
              .toMap());
      await db.insert(
          'computadoras',
          Computadora(
                  procesador: 'Intel i7', discoDuro: '256GB SSD', ram: '16GB')
              .toMap());
    }
  }

  Future<List<Computadora>> fetchComputadoras() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('computadoras');
    return List.generate(maps.length, (i) {
      return Computadora.fromMap(maps[i]);
    });
  }

  Future<void> insertComputadora(Computadora computadora) async {
    final db = await database;
    await db.insert('computadoras', computadora.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateComputadora(Computadora computadora) async {
    final db = await database;
    await db.update(
      'computadoras',
      computadora.toMap(),
      where: "id = ?",
      whereArgs: [computadora.id],
    );
  }

  Future<void> deleteComputadora(int id) async {
    final db = await database;
    await db.delete(
      'computadoras',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
