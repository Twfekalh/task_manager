import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/features/Todo/data/data_sources/TodoLocalDataSource.dart';
import 'package:task_manager/features/Todo/data/data_sources/TodoRemoteDataSource.dart';
import 'package:task_manager/features/Todo/domain/repositories/todo_repo.dart';
import 'package:task_manager/features/Todo/domain/usecase/Add_Todo_UseCase.dart';
import 'package:task_manager/features/Todo/domain/usecase/Delete_Todo_UseCase.dart';
import 'package:task_manager/features/Todo/domain/usecase/Get_Single_Todo_UseCase.dart';
import 'package:task_manager/features/Todo/domain/usecase/Get_Random_Todo_UseCase.dart';
import 'package:task_manager/features/Todo/domain/usecase/Update_Todo_UseCase.dart';
import 'package:task_manager/features/Todo/presentation/bloc/todo_bloc/todo_bloc_bloc.dart';
import 'package:task_manager/features/auth/data/data%20sources/remote_data_source.dart';
import 'package:task_manager/features/auth/data/data%20sources/local_user_data_source.dart';
import 'package:task_manager/features/auth/data/repositories/user_repository_impl.dart';
import 'package:task_manager/features/auth/domain/repositories/user_repositories.dart';
import 'package:task_manager/features/auth/domain/use%20case/fetch_user_UseCase.dart';
import 'package:task_manager/features/auth/domain/use%20case/login_user%20_UseCase.dart';
import 'package:task_manager/features/auth/domain/use%20case/refresh_session_UseCase.dart';
import 'package:task_manager/features/auth/presentation/bloc/log_in_bloc/log_in_bloc.dart';

import '../../features/Todo/data/repositories/todo_repository_Impl.dart';
import '../../features/Todo/domain/usecase/get_todos_usecase.dart';

// الـ GetIt Instance
final getIt = GetIt.instance;

void setuplocator() {
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<TodoRemoteDataSource>(
      () => TodoRemoteDataSourceImpl(client: getIt(), dio: getIt()));

  getIt.registerLazySingleton<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(sharedPreferences: getIt()));

  getIt.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
      ));

  getIt.registerLazySingleton<GetTodosUseCase>(() => GetTodosUseCase(getIt()));
  getIt.registerLazySingleton<AddTodoUseCase>(() => AddTodoUseCase(getIt()));
  getIt.registerLazySingleton<UpdateTodoUseCase>(
      () => UpdateTodoUseCase(getIt()));
  getIt.registerLazySingleton<DeleteTodoUseCase>(
      () => DeleteTodoUseCase(getIt()));
  getIt.registerLazySingleton<GetSingleTodoUseCase>(
      () => GetSingleTodoUseCase(getIt()));
  getIt.registerLazySingleton<GetRandomTodoUseCase>(
      () => GetRandomTodoUseCase(getIt()));

  getIt.registerFactory<TodoBlocBloc>(() => TodoBlocBloc(
        getAllTodos: getIt(),
        getTodoById: getIt(),
        addTodo: getIt(),
        updateTodo: getIt(),
        deleteTodo: getIt(),
        getRandomTodo: getIt(),
      ));

  getIt.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSource('https://dummyjson.com/auth/login'));

  getIt.registerLazySingleton<LocalUserDataSource>(() => LocalUserDataSource());

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<LoginUser>(() => LoginUser(getIt()));
  getIt.registerLazySingleton<FetchUserData>(() => FetchUserData(getIt()));
  getIt.registerLazySingleton<RefreshSession>(() => RefreshSession(getIt()));

  getIt.registerFactory<LogInBloc>(
    () => LogInBloc(
      loginUser: getIt(),
      fetchUserData: getIt(),
      refreshSession: getIt(),
    ),
  );
}
