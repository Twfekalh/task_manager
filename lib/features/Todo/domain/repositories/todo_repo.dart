import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/Todo/domain/entaties/todo_entities.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos(
      {required int skip, required int limit});

  Future<Either<Failure, Todo>> getTodoById(int id);

  Future<Either<Failure, Todo>> getRandomTodo();

  Future<Either<Failure, Todo>> addTodo(Todo todo);

  Future<Either<Failure, Todo>> updateTodo(Todo todo);

  Future<Either<Failure, void>> deleteTodo(int id);
  Future<Either<Failure, Todo>> getSingleTodo(int id);
}
