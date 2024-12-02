import 'package:get_it/get_it.dart';
import 'package:task_manager/features/Todo/data/data_sources/TodoLocalDataSource.dart';
import 'package:task_manager/features/Todo/domain/usecase/Delete_Todo_UseCase.dart';
import 'package:task_manager/features/Todo/domain/usecase/Get_Single_Todo_UseCase.dart';
import '../../features/Todo/data/data_sources/TodoRemoteDataSource.dart';
import '../../features/Todo/data/repositories/todo_repository_Impl.dart';
import '../../features/Todo/domain/repositories/todo_repo.dart';
import '../../features/Todo/domain/usecase/Add_Todo_UseCase.dart';
import '../../features/Todo/domain/usecase/Get_Random_Todo_UseCase.dart';
import '../../features/Todo/domain/usecase/Update_Todo_UseCase.dart';
import '../../features/Todo/domain/usecase/get_todos_usecase.dart';
import '../../features/Todo/presentation/bloc/todo_bloc/todo_bloc.dart';

final getIt = GetIt.instance;

void setuplocator() {
  // Data sources
  getIt.registerLazySingleton<TodoRemoteDataSource>(
      () => TodoRemoteDataSourceImpl(dio: getIt()));
  getIt.registerLazySingleton<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(sharedPreferences: getIt()));

  // Repositories
  getIt.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
      ));

  // UseCases for Todo
  getIt.registerLazySingleton<GetTodosUseCase>(() => GetTodosUseCase(getIt()));
  getIt.registerLazySingleton<AddTodoUseCase>(() => AddTodoUseCase(getIt()));
  getIt.registerLazySingleton<UpdateTodoUseCase>(
      () => UpdateTodoUseCase(getIt()));
  getIt.registerLazySingleton<DeleteTodoUseCase>(
      () => DeleteTodoUseCase(getIt()));

  // Register missing UseCases
  getIt.registerLazySingleton<GetSingleTodoUseCase>(
      () => GetSingleTodoUseCase(getIt()));
  getIt.registerLazySingleton<GetRandomTodoUseCase>(
      () => GetRandomTodoUseCase(getIt()));

  // BLoC for Todo
  getIt.registerFactory<TodoBloc>(() => TodoBloc(
        getTodosUseCase: getIt(),
        addTodoUseCase: getIt(),
        updateTodoUseCase: getIt(),
        deleteTodoUseCase: getIt(),
        getSingleTodoUseCase: getIt(),
        getRandomTodoUseCase: getIt(),
      ));
}
