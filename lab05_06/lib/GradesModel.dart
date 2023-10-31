import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Future<Database> database;


Future<Database> initDatabase() async {
  final db = await openDatabase(
    join(await getDatabasesPath(), 'grades.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE grades(sid INTEGER PRIMARY KEY, grade TEXT)',
      );
    },
    version: 1,
  );

  return db;
}
Future<List<Map<String, dynamic>>> getAllGrades() async {
  final db = await initDatabase();
  final List<Map<String, dynamic>> maps = await db.query('grades');
  return maps;
}

Future<int> insertGrade(Map<String, dynamic> row) async {
  final db = await initDatabase();
  final result = await db.insert('grades', row,
      conflictAlgorithm: ConflictAlgorithm.replace);
  return result;
}
