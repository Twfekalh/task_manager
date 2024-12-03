import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String todo; // العنوان
  final String details;
  final bool completed;
  final int userId;

  const Todo({
    required this.id,
    required this.todo,
    required this.details,
    required this.completed,
    required this.userId,
  });

  Todo copyWith({
    int? id,
    String? todo,
    String? details,
    bool? completed,
    int? userId,
  }) {
    return Todo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      details: details ?? this.details,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [id, todo, details, completed, userId];
}
