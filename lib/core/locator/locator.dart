import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/Todo/domain/usecase/get_todo_by_id_usecase.dart';
import 'package:task_manager/features/Todo/domain/usecase/get_todos_usecase.dart';

import '../../features/Todo/data/data_sources/TodoLocalDataSource.dart';
import '../../features/Todo/data/data_sources/TodoRemoteDataSource.dart';
import '../../features/Todo/data/repositories/todo_repository_Impl.dart';
import '../../features/Todo/domain/repositories/todo_repo.dart';
import '../../features/Todo/domain/usecase/Add_Todo_UseCase.dart';
import '../../features/Todo/domain/usecase/Delete_Todo_UseCase.dart';
import '../../features/Todo/domain/usecase/Get_Random_Todo_UseCase.dart';
import '../../features/Todo/domain/usecase/Get_Single_Todo_UseCase.dart';

import '../../features/Todo/domain/usecase/Update_Todo_UseCase.dart';
import '../../features/Todo/presentation/bloc/todo_bloc/todo_bloc_bloc.dart';
import '../../features/auth/data/data sources/local_user_data_source.dart';
import '../../features/auth/data/data sources/remote_data_source.dart';
import '../../features/auth/data/repositories/user_repository_Impl.dart';
import '../../features/auth/domain/repositories/user_repositories.dart';
import '../../features/auth/domain/use case/fetch_user_UseCase.dart';
import '../../features/auth/domain/use case/login_user _UseCase.dart';
import '../../features/auth/domain/use case/refresh_session_UseCase.dart';
import '../../features/auth/presentation/bloc/log_in_bloc/log_in_bloc.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfo(connectivity: Connectivity()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(
      dio: sl<Dio>(),
      networkInfo: sl<NetworkInfo>(), // Pass NetworkInfo here
    ),
  );
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      remoteDataSource: sl<TodoRemoteDataSource>(),
      localDataSource: sl<TodoLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetTodosUseCase>(
      () => GetTodosUseCase(sl<TodoRepository>()));
  sl.registerLazySingleton<AddTodoUseCase>(
      () => AddTodoUseCase(sl<TodoRepository>()));
  sl.registerLazySingleton<UpdateTodoUseCase>(
      () => UpdateTodoUseCase(sl<TodoRepository>()));
  sl.registerLazySingleton<DeleteTodoUseCase>(
      () => DeleteTodoUseCase(sl<TodoRepository>()));
  sl.registerLazySingleton<GetSingleTodoUseCase>(
      () => GetSingleTodoUseCase(sl<TodoRepository>()));
  sl.registerLazySingleton<GetRandomTodoUseCase>(
      () => GetRandomTodoUseCase(sl<TodoRepository>()));

  sl.registerLazySingleton<GetTodoByIdUseCase>(
      () => GetTodoByIdUseCase(sl<TodoRepository>()));

  sl.registerFactory<TodoBlocBloc>(() => TodoBlocBloc(
        getAllTodos: sl<GetTodosUseCase>(),
        getTodoById: sl<GetTodoByIdUseCase>(),
        addTodo: sl<AddTodoUseCase>(),
        updateTodo: sl<UpdateTodoUseCase>(),
        deleteTodo: sl<DeleteTodoUseCase>(),
        getRandomTodo: sl<GetRandomTodoUseCase>(),
      ));

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSource('https://dummyjson.com/auth/login'));

  sl.registerLazySingleton<LocalUserDataSource>(() => LocalUserDataSource());

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl<UserRemoteDataSource>(),
      localDataSource: sl<LocalUserDataSource>(),
    ),
  );

  sl.registerLazySingleton<LoginUser>(() => LoginUser(sl<UserRepository>()));
  sl.registerLazySingleton<FetchUserData>(
      () => FetchUserData(sl<UserRepository>()));
  sl.registerLazySingleton<RefreshSession>(
      () => RefreshSession(sl<UserRepository>()));

  sl.registerFactory<LogInBloc>(
    () => LogInBloc(
      loginUser: sl<LoginUser>(),
      fetchUserData: sl<FetchUserData>(),
      refreshSession: sl<RefreshSession>(),
    ),
  );
}
