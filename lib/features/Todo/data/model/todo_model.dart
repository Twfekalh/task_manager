class TodoModel {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  TodoModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  static List<TodoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TodoModel.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<TodoModel> todoList) {
    return todoList.map((todo) => todo.toJson()).toList();
  }
}
