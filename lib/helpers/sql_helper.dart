import 'package:app/database/content_db.dart';
import 'package:app/database/question_db.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late DatabaseHelper _databaseHelper;
  static late Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }
  Future<Database> get database async {
    _database ??= _database = await initializeDatabase();
    return _database;
  }
  Future<String> get fullpath async {
    const name = 'content.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  // inicializacion de la base de datos
  Future<Database> initializeDatabase() async {
    String path = await fullpath;
    Database database = await openDatabase(path, version: 1, onCreate: createContentDB,singleInstance: true);
    return database;
  }
  Future<void> createContentDB(Database database, int version) async => await ContentDB().createTable(database);
  Future<void> create(Database database, int version) async => await QuestionDB().createTable(database);
}
