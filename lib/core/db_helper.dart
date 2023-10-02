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
    try {
      print("Query function called");
      final result = await _db!.query(_tableName);
      return result;
    } catch (error) {
      print("Error querying the database: $error");
      return []; // Return an empty list in case of an error
    }
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

  static Future<int> updateTask(Task task) async {
    print("Updating task with id: ${task.id}");

    return await _db!.update(
      _tableName,
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
