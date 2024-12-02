import 'package:dartz/dartz.dart';
import 'package:task_manager/features/Todo/domain/repositories/todo_repo.dart';

import '../../../../core/errors/failure.dart';

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) {
    return repository.deleteTodo(id);
  }
}
