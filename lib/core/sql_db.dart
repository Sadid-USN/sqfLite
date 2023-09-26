import 'package:sqflite/sqflite.dart';
import 'package:sql_db/models/task_model.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "task";

  static Future<void> initDB() async {
    if (_db != null) {
      return;
    }
    try {
      String path = "${await getDatabasesPath()} task.db";
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) {
          print("create a new one");
          return db.execute(''' CREATE TABLE $_tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title STRING, 
          note TEXT, 
          date STRING, 
          startTime STRING, 
          endTime STRING, 
          remind INTEGER, 
          repeat STRING, 
          color INTEGER, 
          isCompleted INTEGERF)''');
        },
      );
    } catch (error) {
      print(error);
    }
  }

  static Future<int> insert(Task? task) async {
    print("insert func called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("Query function called");
    return await _db!.query(_tableName);
  }

  static Future<int> delete(Task task) async {
    print("Object ${task.id} is deleted");

    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate(
      '''
     UPDATE task
     SET isCompleted = ?
     WHERE id = ?
   
         ''',
      [1, id],
    );
  }
}
