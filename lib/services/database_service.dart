import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


import '../models/model.dart';
import '../models/computer.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'flutter_sqflite_databasev2.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store models
  // and a table to store computers.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {models} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE models(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
    );
    // Run the CREATE {computers} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE computers(id INTEGER PRIMARY KEY, name TEXT, ram INTEGER, color INTEGER, modelId INTEGER, FOREIGN KEY (modelId) REFERENCES models(id) ON DELETE SET NULL)',
    );
  }

  // Define a function that inserts models into the database
  Future<void> insertModel(Model model) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Insert the Model into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same model is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'models',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertComputer(Computer computer) async {
    final db = await _databaseService.database;
    await db.insert(
      'computers',
      computer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the models from the models table.
  Future<List<Model>> models() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Models.
    final List<Map<String, dynamic>> maps = await db.query('models');

    // Convert the List<Map<String, dynamic> into a List<Model>.
    return List.generate(maps.length, (index) => Model.fromMap(maps[index]));
  }

  Future<Model> model(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('models', where: 'id = ?', whereArgs: [id]);
    return Model.fromMap(maps[0]);
  }

  Future<List<Computer>> computers() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('computers');
    return List.generate(maps.length, (index) => Computer.fromMap(maps[index]));
  }

  // A method that updates a model data from the models table.
  Future<void> updateModel(Model model) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Update the given model
    await db.update(
      'models',
      model.toMap(),
      // Ensure that the Model has a matching id.
      where: 'id = ?',
      // Pass the Model's id as a whereArg to prevent SQL injection.
      whereArgs: [model.id],
    );
  }

  Future<void> updateComputer(Computer computer) async {
    final db = await _databaseService.database;
    await db.update('computers', computer.toMap(), where: 'id = ?', whereArgs: [computer.id]);
  }

  // A method that deletes a model data from the models table.
  Future<void> deleteModel(int id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Remove the Model from the database.
    await db.delete(
      'models',
      // Use a `where` clause to delete a specific model.
      where: 'id = ?',
      // Pass the Model's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> deleteComputer(int id) async {
    final db = await _databaseService.database;
    await db.delete('computers', where: 'id = ?', whereArgs: [id]);
  }
}
