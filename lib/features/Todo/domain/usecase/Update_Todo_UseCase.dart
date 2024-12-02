import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entaties/todo_entities.dart';
import '../repositories/todo_repo.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<Either<Failure, Todo>> call(Todo todo) {
    return repository.updateTodo(todo);
  }
}
