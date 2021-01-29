import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class Database {
  static Future<sqlite.Database> init() async {
    final database = await sqlite.getDatabasesPath();
    return sqlite.openDatabase(
      path.join(database, 'place.db'),
      version: 1,
      onCreate: Database.createSchema
    );
  }

  static Future<void> createSchema(db, version) {
    return db.execute(
      "CREATE TABLE place (" +
        "id TEXT PRIMARY KEY," +
        "title TEXT," +
        "image TEXT" +
      ")"
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> values) async {
    final db = await Database.init();
    await db.insert(
      table,
      values,
      conflictAlgorithm: sqlite.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await Database.init();
    return db.query(table);
  }
}
