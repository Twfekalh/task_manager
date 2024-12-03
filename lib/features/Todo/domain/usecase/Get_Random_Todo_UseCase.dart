import 'package:dartz/dartz.dart';
import 'package:task_manager/features/Todo/domain/repositories/todo_repo.dart';

import '../../../../core/errors/failure.dart';
import '../entaties/todo_entities.dart';

class GetRandomTodoUseCase {
  final TodoRepository repository;

  GetRandomTodoUseCase(this.repository);

  Future<Either<Failure, Todo>> call() {
    return repository.getRandomTodo();
  }
}
