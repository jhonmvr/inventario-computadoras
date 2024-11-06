
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/computer.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'computer_database.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE computers(id INTEGER PRIMARY KEY, procesador TEXT, ram TEXT, discoDuro TEXT)',
    );
  }

  Future<void> insertComputer(Computer computer) async {
    final db = await _databaseService.database;
    await db.insert('computers', computer.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Computer>> computers() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('computers');
    return List.generate(maps.length, (index) => Computer.fromMap(maps[index]));
  }

  Future<void> updateComputer(Computer computer) async {
    final db = await _databaseService.database;
    await db.update('computers', computer.toMap(), where: 'id = ?', whereArgs: [computer.id]);
  }

  Future<void> deleteComputer(int id) async {
    final db = await _databaseService.database;
    await db.delete('computers', where: 'id = ?', whereArgs: [id]);
  }
}
