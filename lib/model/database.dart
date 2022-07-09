import 'package:goals/model/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Helper for Todo database
class TodoHelper {
  static String tableName = 'todos';

  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'goals.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          date TEXT,
          done INTEGER NOT NULL
        );
''');
      },
    );
  }

  static Future<int> insertTodo(Todo todo) async {
    final db = await database();

    final index = await db.insert(tableName, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return index;
  }

  static Future<List<Todo>> getTodos() async {
    final db = await database();

    final List<Map<String, dynamic>> raw = await db.query(tableName);

    List<Todo> list = raw.map((element) => Todo.fromMap(element)).toList();

    return list;
  }

  static Future<void> removeTodo(Todo todo) async {
    final db = await database();

    await db.delete(tableName, where: "title = ?", whereArgs: [todo.title]);
  }

  static Future<void> updateTodo(int index, Todo todo) async {
    final db = await database();

    await db
        .update(tableName, todo.toMap(), where: "id = ?", whereArgs: [index]);
  }
}
