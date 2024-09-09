import 'package:medical_reminder_app/features/home/data/models/medication_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'medication_repository.dart';

class MedicationRepositoryImpl implements MedicationRepository {
  static final MedicationRepositoryImpl _instance =
      MedicationRepositoryImpl._init();
  static Database? _database;

  MedicationRepositoryImpl._init();

  factory MedicationRepositoryImpl() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('medication.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE medications (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        dosage TEXT NOT NULL,
        frequency TEXT NOT NULL,
        time TEXT NOT NULL,
        startDate TEXT NOT NULL,
        isCompleted INTEGER NOT NULL,
        type TEXT,
        days TEXT
      )
    ''');
  }

  @override
  Future<int> addMedication(Medication medication) async {
    final db = await database;
    return await db.insert('medications', medication.toMap());
  }

  @override
  Future<List<Medication>> getAllMedications() async {
    final db = await database;
    final result = await db.query('medications');
    return result.map((json) => Medication.fromMap(json)).toList();
  }

  @override
  Future<int> updateMedication(Medication medication) async {
    final db = await database;
    return db.update(
      'medications',
      medication.toMap(),
      where: 'id = ?',
      whereArgs: [medication.id],
    );
  }

  @override
  Future<int> deleteMedication(String id) async {
    final db = await database;
    return await db.delete('medications', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
