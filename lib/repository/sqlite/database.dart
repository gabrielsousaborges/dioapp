import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: '''CREATE TABLE tarefas (
         id INTEGER PRIMARY KEY AUTOINCREMENT
         descricao TEXT,
         concluido INTEGER
         );'''
};

class SQLiteDatabase {
  static Database? db;

  Future<Database> getDatabase() async {
    if (db == null) {
      return await iniciarBancoDados();
    } else {
      return db!;
    }
  }

  Future<Database> iniciarBancoDados() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: scripts.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    });

    return db;
  }
}
