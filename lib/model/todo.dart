final String tableTodo = "todos";

class TodoField {
  static final List<String> values = [
    todoId,
    todoItem,
    toDone,
    desc,
    name,
    dueDate,
    createdDate,
  ];

  static final String todoId = "_todoId";
  static final String todoItem = "todoItem";
  static final String toDone = "toDone";
  static final String desc = "desc";
  static final String name = "name";
  static final String dueDate = "dueDate";
  static final String createdDate = "createdDate";
}

class Todo {
  final int? todoId;
  final String todoItem;
  final int toDone;
  final String desc;
  final String name;
  final DateTime dueDate;
  final DateTime createdDate;

  const Todo({
    this.todoId,
    required this.todoItem,
    required this.toDone,
    required this.desc,
    required this.name,
    required this.dueDate,
    required this.createdDate,
  });

  Todo copy({
    int? todoId,
    String? todoItem,
    int? toDone,
    DateTime? createdDate,
    DateTime? dueDate,
    String? desc,
    String? name,
  }) =>
      Todo(
        todoItem: todoItem ?? this.todoItem,
        toDone: toDone ?? this.toDone,
        createdDate: createdDate ?? this.createdDate,
        dueDate: dueDate ?? this.dueDate,
        desc: desc ?? this.desc,
        name: name ?? this.name,
      );

  static Todo fromJson(Map<String, Object?> json) => Todo(
        todoId: json[TodoField.todoId] as int?,
        todoItem: json[TodoField.todoItem] as String,
        toDone: json[TodoField.toDone] as int,
        createdDate: DateTime.parse(json[TodoField.createdDate] as String),
        dueDate: DateTime.parse(json[TodoField.dueDate] as String),
        desc: json[TodoField.desc] as String,
        name: json[TodoField.name] as String,
      );

  Map<String, Object?> toJson() => {
        TodoField.todoId: todoId,
        TodoField.todoItem: todoItem,
        TodoField.toDone: toDone,
        TodoField.desc: desc,
        TodoField.name: name,
        TodoField.createdDate: createdDate.toIso8601String(),
        TodoField.dueDate: dueDate.toIso8601String(),
      };
}
