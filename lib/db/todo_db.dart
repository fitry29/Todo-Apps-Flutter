import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapps/model/todo.dart';

class TodoDatabse {
  static final TodoDatabse instance = TodoDatabse._init();

  static Database? _database;

  TodoDatabse._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final textType = "TEXT NOT NULL";

    await db.execute('''
CREATE TABLE $tableTodo(
  ${TodoField.todoId} $idType,
  ${TodoField.todoItem} $textType,
  ${TodoField.toDone} INTEGER,
  ${TodoField.name} $textType,
  ${TodoField.desc} $textType,
  ${TodoField.dueDate} $textType,
  ${TodoField.createdDate} $textType
) 
 ''');
  }

  Future<Todo> create(Todo todo) async {
    final db = await instance.database;

    final todoId = await db.insert(tableTodo, todo.toJson());
    return todo.copy(todoId: todoId);
  }

  Future<Todo> readTodo(int todoId) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTodo,
      columns: TodoField.values,
      where: '${TodoField.todoId}',
      whereArgs: [todoId],
    );

    if (maps.isNotEmpty) {
      return Todo.fromJson(maps.first);
    } else {
      throw Exception("Id not found");
    }
  }

  Future<List<Todo>> readAllTodo() async {
    final db = await instance.database;
    final orderBy = '${TodoField.todoId} ASC';
    final result = await db.query(tableTodo, orderBy: orderBy);

    return result.map((json) => Todo.fromJson(json)).toList();
  }

  Future<int> update(Todo todo) async {
    final db = await instance.database;

    return db.update(
      tableTodo,
      todo.toJson(),
      where: '${TodoField.todoId} = ?',
      whereArgs: [todo.todoId],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableTodo,
      where: '${TodoField.todoId} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
