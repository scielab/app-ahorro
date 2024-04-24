

import 'package:app/helpers/sql_helper.dart';
import 'package:app/models/question_model.dart';
import 'package:sqflite/sqflite.dart';

class ContentDB {
  
  Future<void> createTable(Database database) async {
    await database.execute('''
          CREATE TABLE Content (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              content TEXT,
              imageurl TEXT, 
          )
      ''');
  }
  // Create
  Future<void> create(ContentDatabase contentDatabase) async {
    final db = await DatabaseHelper().database;
    await db.insert('Content', contentDatabase.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
      // Add Exception 

  }

  // Get Single
  Future<ContentDatabase> getQuestionById(int id) async {
    final db = await DatabaseHelper().database;
    List<Map<String, dynamic>> maps = await db.query('Content',where: 'id = ?', whereArgs: [id]);
    if(maps.isNotEmpty) {
      return ContentDatabase(
        id: maps[0]['id'],
        title: maps[0]['title'],
        content: maps[0]['content'],
        imageurl: maps[0]['image'] ?? '',
      ); 
    } else {
      throw Exception('No se encontró una pregunta con el ID proporcionado.');
    }
  }

  // Get All
  Future<List<ContentDatabase>> fetchAllQuestions() async {
    final db = await DatabaseHelper().database;
    final List<Map<String,Object?>> contentMaps = await db.query('Content');
    return [
      for (final {
            'id': id as int,
            'title': title as String,
            'content': content as String,
          } in contentMaps) ContentDatabase(id: id, title: title, content: content),
    ];
    // Add Exception 
  }

  // Update
  Future<void> update(ContentDatabase contentDatabase) async {
    final db = await DatabaseHelper().database;
    await db.update('Content', contentDatabase.toMap(),where: 'id = ?',whereArgs: [contentDatabase.id]);
      // Add Exception 

  }
  // Delete
  Future<void> delete(ContentDatabase contentDatabase) async {
    final db = await DatabaseHelper().database;
    await db.delete('Content',where: 'id = ?',whereArgs: [contentDatabase.id]);
    // Add Exception 

  }
}