import 'package:dartz/dartz.dart';
import 'package:task_manager/features/Todo/domain/entaties/todo_entities.dart';
import 'package:task_manager/features/Todo/domain/repositories/todo_repo.dart';

import '../../../../core/errors/failure.dart';

// Get Todos Use Case
class GetTodosUseCase {
  final TodoRepository repository;

  GetTodosUseCase(this.repository);

  Future<Either<Failure, List<Todo>>> call(
      {required int skip, required int limit}) {
    return repository.getTodos(skip: skip, limit: limit);
  }
}
