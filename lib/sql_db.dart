import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLdb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
      return _db;
    } else {
      return _db;
    }
  }

  initDB() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'todo.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);

    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newVersion) async {
    print('========== ON UPGRADE ============');
    await db.execute("ALTER TABLE todo ADD COLUMN title TEXT");
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
        CREATE TABLE "todos"
        (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "title" TEXT NOT NULL,
        "todo" TEXT NOT NULL,
        "done" INTEGER NOT NULL
        )

        ''');

    await batch.commit();
    print('======= On CRAETE DB AND TABLE =======');
  }

  // SELECT
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  //INSERT
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  // UPDATE
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  // DELETE
  deleteOneData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  deleteAllDataBase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'todo.db');
    await deleteDatabase(path);
  }
}
