import 'package:dartz/dartz.dart';
import 'package:task_manager/features/Todo/domain/repositories/todo_repo.dart';

import '../../../../core/errors/failure.dart';
import '../entaties/todo_entities.dart';

class AddTodoUseCase {
  final TodoRepository repository;
  AddTodoUseCase(this.repository);

  Future<Either<Failure, Todo>> call(Todo todo) {
    return repository.addTodo(todo);
  }
}
