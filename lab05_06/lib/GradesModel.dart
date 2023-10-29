import 'main.dart';
import 'package:sqflite/sqflite.dart';


Future<List<Map<String,dynamic>>> getAllGrades() async{
  final db = await database;

  final List<Map<String, dynamic>> maps = await db.query('grades');

  return maps;
}


Future<int> insertGrade(Map<String, dynamic> row) async{
  final db = await database;

  await db.insert(
    'grades',
    row,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return 1;
}


Future<int> updateGrade(Map<String, dynamic> row) async{
  final db = await database;

  await db.insert(
    'grades',
    row.forEach((key, value) {value = 'A';}),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return 1;
}


Future<int> deleteGrade(String sid) async{
  final db = await database;
  
  await db.delete(
    'grades',
    
    where: 'sid = ?',
    
    whereArgs: [int.parse(sid)],
  );
  return 1;
}