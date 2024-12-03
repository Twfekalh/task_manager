import 'package:dartz/dartz.dart';
import 'package:task_manager/features/Todo/domain/entaties/todo_entities.dart';
import 'package:task_manager/features/Todo/domain/repositories/todo_repo.dart';

import '../../../../core/errors/failure.dart';

class GetSingleTodoUseCase {
  final TodoRepository repository;

  GetSingleTodoUseCase(this.repository);

  Future<Either<Failure, Todo>> call(int id) async {
    return await repository.getSingleTodo(id);
  }
}
