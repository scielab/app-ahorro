

import 'package:app/helpers/sql_helper.dart';
import 'package:app/models/question_model.dart';
import 'package:sqflite/sqflite.dart';

class QuestionDB {
  
  Future<void> createTable(Database database) async {
    await database.execute('''
          CREATE TABLE Question (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              contentid INTEGER,
              question TEXT
          )
      ''');
  }
  // Create
  Future<void> create(QuestionDatabase questionDatabase) async {
    final db = await DatabaseHelper().database;
    await db.insert('Question', questionDatabase.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
      // Add Exception 

  }

  // Get Single
  Future<QuestionDatabase> getQuestionById(int id) async {
    final db = await DatabaseHelper().database;
    List<Map<String, dynamic>> maps = await db.query('Question',where: 'id = ?', whereArgs: [id]);
    if(maps.isNotEmpty) {
      return QuestionDatabase(
        id: maps[0]['id'],
        contentid: maps[0]['contentid'],
        question: maps[0]['question'],
      ); 
    } else {
      throw Exception('No se encontró una pregunta con el ID proporcionado.');
    }
  }

  // Get All
  Future<List<QuestionDatabase>> fetchAllQuestions() async {
    final db = await DatabaseHelper().database;
    final List<Map<String,Object?>> questionMaps = await db.query('Question');
    return [
      for (final {
            'id': id as int,
            'contentid': contentid as int,
            'question': question as String,
          } in questionMaps) QuestionDatabase(id: id, contentid: contentid, question: question),
    ];
    // Add Exception 
  }

  // Update
  Future<void> update(QuestionDatabase questionDatabase) async {
    final db = await DatabaseHelper().database;
    await db.update('Question', questionDatabase.toMap(),where: 'id = ?',whereArgs: [questionDatabase.id]);
      // Add Exception 

  }
  // Delete
  Future<void> delete(QuestionDatabase questionDatabase) async {
    final db = await DatabaseHelper().database;
    await db.delete('Question',where: 'id = ?',whereArgs: [questionDatabase.id]);
    // Add Exception 

  }
}