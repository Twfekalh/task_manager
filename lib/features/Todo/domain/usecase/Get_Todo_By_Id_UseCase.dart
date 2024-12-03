import 'package:dartz/dartz.dart';
import 'package:task_manager/features/Todo/domain/repositories/todo_repo.dart';

import '../../../../core/errors/failure.dart';
import '../entaties/todo_entities.dart';

class GetTodoByIdUseCase {
  final TodoRepository repository;

  GetTodoByIdUseCase(this.repository);

  Future<Either<Failure, Todo>> call(int id) {
    return repository.getTodoById(id);
  }
}
