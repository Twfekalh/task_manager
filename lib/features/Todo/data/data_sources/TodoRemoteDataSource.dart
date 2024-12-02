import 'package:dio/dio.dart';
import 'package:task_manager/core/errors/exception.dart';
import 'package:task_manager/features/Todo/data/model/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos({required int skip, required int limit});
  Future<TodoModel> getTodoById(int id);
  Future<TodoModel> getRandomTodo();
  Future<TodoModel> addTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<bool> deleteTodo(int id);
  Future<TodoModel> getSingleTodoRemote(int id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final Dio dio;

  TodoRemoteDataSourceImpl({required this.dio, required Object client});

  @override
  Future<List<TodoModel>> getTodos(
      {required int skip, required int limit}) async {
    final response =
        await dio.get('https://dummyjson.com/todos', queryParameters: {
      'limit': limit,
      'skip': skip,
    });

    if (response.statusCode == 200) {
      final data = response.data['todos'] as List;
      return data.map((todo) => TodoModel.fromJson(todo)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> getTodoById(int id) async {
    final response = await dio.get('https://dummyjson.com/todos/$id');

    if (response.statusCode == 200) {
      return TodoModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> getRandomTodo() async {
    final response = await dio.get('https://dummyjson.com/todos/random');

    if (response.statusCode == 200) {
      return TodoModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> addTodo(TodoModel todo) async {
    final response = await dio.post(
      'https://dummyjson.com/todos/add',
      data: todo.toJson(),
    );

    if (response.statusCode == 200) {
      return TodoModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    final response = await dio.put(
      'https://dummyjson.com/todos/${todo.id}',
      data: todo.toJson(),
    );

    if (response.statusCode == 200) {
      return TodoModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> deleteTodo(int id) async {
    final response = await dio.delete('https://dummyjson.com/todos/$id');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> getSingleTodoRemote(int id) async {
    final response = await dio.get('https://dummyjson.com/todos/$id');

    if (response.statusCode == 200) {
      return TodoModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
