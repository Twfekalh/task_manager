import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/Todo/data/data_sources/TodoLocalDataSource.dart';
import 'package:task_manager/features/Todo/data/data_sources/TodoRemoteDataSource.dart';
import 'package:task_manager/features/Todo/domain/entaties/todo_entities.dart';
import 'package:task_manager/features/Todo/data/model/todo_model.dart';
import 'package:task_manager/features/Todo/domain/repositories/todo_repo.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Todo>>> getTodos(
      {required int skip, required int limit}) async {
    try {
      final List<TodoModel> localTodos = await localDataSource.getCachedTodos();

      return Right(localTodos
          .map((todo) => Todo(
                id: todo.id,
                todo: todo.todo,
                completed: todo.completed,
                userId: todo.userId,
                details: 'No details available',
              ))
          .toList());
    } catch (e) {
      return Left(ServerFailure('Failed to load Todos from cache.'));
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodoById(int id) async {
    try {
      final List<TodoModel> todoModel = await localDataSource.getCachedTodos();
      final todo = todoModel.firstWhere((item) => item.id == id);

      return Right(Todo(
        id: todo.id,
        todo: todo.todo,
        completed: todo.completed,
        userId: todo.userId,
        details: 'No details available',
      ));
    } catch (e) {
      return Left(ServerFailure('Failed to load Todo by ID from cache.'));
    }
  }

  @override
  Future<Either<Failure, Todo>> getRandomTodo() async {
    try {
      final TodoModel todoModel = await remoteDataSource.getRandomTodo();
      // إضافة details يدويًا هنا
      return Right(Todo(
        id: todoModel.id,
        todo: todoModel.todo,
        completed: todoModel.completed,
        userId: todoModel.userId,
        details: 'No details available',
      ));
    } catch (e) {
      return Left(ServerFailure('Failed to load random Todo.'));
    }
  }

  @override
  Future<Either<Failure, Todo>> addTodo(Todo todo) async {
    try {
      final TodoModel todoModel = await remoteDataSource.addTodo(TodoModel(
        id: todo.id,
        todo: todo.todo,
        completed: todo.completed,
        userId: todo.userId,
      ));
      return Right(Todo(
        id: todoModel.id,
        todo: todoModel.todo,
        completed: todoModel.completed,
        userId: todoModel.userId,
        details: 'No details available',
      ));
    } catch (e) {
      return Left(ServerFailure('Failed to add Todo.'));
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async {
    try {
      final TodoModel todoModel = await remoteDataSource.updateTodo(TodoModel(
        id: todo.id,
        todo: todo.todo,
        completed: todo.completed,
        userId: todo.userId,
      ));
      return Right(Todo(
        id: todoModel.id,
        todo: todoModel.todo,
        completed: todoModel.completed,
        userId: todoModel.userId,
        details: 'No details available',
      ));
    } catch (e) {
      return Left(ServerFailure('Failed to update Todo.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      final success = await remoteDataSource.deleteTodo(id);
      if (success) {
        return Right(null);
      } else {
        return Left(ServerFailure('Failed to delete Todo.'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to delete Todo.'));
    }
  }

  @override
  Future<Either<Failure, Todo>> getSingleTodo(int id) async {
    try {
      final TodoModel todoModel =
          await remoteDataSource.getSingleTodoRemote(id);
      return Right(Todo(
        id: todoModel.id,
        todo: todoModel.todo,
        completed: todoModel.completed,
        userId: todoModel.userId,
        details: 'No details available',
      ));
    } catch (e) {
      return Left(ServerFailure('Failed to load single Todo.'));
    }
  }
}
