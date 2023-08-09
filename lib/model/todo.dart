final String tableTodo = "todos";

class TodoField {
  static final List<String> values = [
    todoId,
    todoItem,
    toDone,
  ];

  static final String todoId = "_todoId";
  static final String todoItem = "todoItem";
  static final String toDone = "toDone";
}

class Todo {
  final int? todoId;
  final String todoItem;
  final int toDone;

  const Todo({
    this.todoId,
    required this.todoItem,
    required this.toDone,
  });

  Todo copy({
    int? todoId,
    String? todoItem,
    int? toDone,
  }) =>
      Todo(
        todoItem: todoItem ?? this.todoItem,
        toDone: toDone ?? this.toDone,
      );

  static Todo fromJson(Map<String, Object?> json) => Todo(
        todoId: json[TodoField.todoId] as int?,
        todoItem: json[TodoField.todoItem] as String,
        toDone: json[TodoField.toDone] as int,
      );

  Map<String, Object?> toJson() => {
        TodoField.todoId: todoId,
        TodoField.todoItem: todoItem,
        TodoField.toDone: toDone,
      };
}
