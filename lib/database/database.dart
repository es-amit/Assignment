import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:todo_task/model/todo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      isCompleted INTEGER,
      reminder INTEGER
    )
    ''');
  }

  Future<int> addTodo(Todo todo) async {
    final db = await instance.database;
    return db.insert('todos', todo.toMap());
  }

  Future<List<Todo>> getTodos() async {
    final db = await instance.database;
    final result = await db.query('todos');

    return result.map((json) => Todo.fromMap(json)).toList();
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await instance.database;
    return db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    final db = await instance.database;
    return db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
