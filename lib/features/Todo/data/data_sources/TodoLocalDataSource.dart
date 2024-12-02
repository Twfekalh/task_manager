import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:task_manager/features/Todo/data/model/todo_model.dart';

class CacheException implements Exception {}

const String CACHED_TODOS_KEY = 'CACHED_TODOS';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getCachedTodos();
  Future<void> cacheTodos(List<TodoModel> todos);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;

  TodoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TodoModel>> getCachedTodos() async {
    try {
      final jsonString = sharedPreferences.getString(CACHED_TODOS_KEY);
      if (jsonString != null) {
        final List<dynamic> decodedJson = json.decode(jsonString);
        return decodedJson.map((todo) => TodoModel.fromJson(todo)).toList();
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTodos(List<TodoModel> todos) async {
    try {
      final jsonString =
          json.encode(todos.map((todo) => todo.toJson()).toList());
      await sharedPreferences.setString(CACHED_TODOS_KEY, jsonString);
    } catch (e) {
      throw CacheException();
    }
  }
}
