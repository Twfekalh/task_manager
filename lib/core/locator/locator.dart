// lib/core/locator/locator.dart
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:task_manager/features/auth/data/data%20sources/remote_data_source.dart';
import 'package:task_manager/features/auth/data/data%20sources/local_user_data_source.dart';
import 'package:task_manager/features/auth/data/repositories/user_repository_impl.dart';
import 'package:task_manager/features/auth/domain/repositories/user_repositories.dart';
import 'package:task_manager/features/auth/domain/use%20case/fetch_user_UseCase.dart';
import 'package:task_manager/features/auth/domain/use%20case/login_user%20_UseCase.dart';
import 'package:task_manager/features/auth/domain/use%20case/refresh_session_UseCase.dart';
import 'package:task_manager/features/auth/presentation/bloc/log_in_bloc/log_in_bloc.dart';

final getIt = GetIt.instance;

void setuplocator() {
  // تسجيل RemoteDataSource
  getIt.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSource('https://dummyjson.com/auth/login'));

  // تسجيل LocalDataSource
  getIt.registerLazySingleton<LocalUserDataSource>(() => LocalUserDataSource());

  // تسجيل UserRepository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );

  // تسجيل UseCases
  getIt.registerLazySingleton<LoginUser>(() => LoginUser(getIt()));
  getIt.registerLazySingleton<FetchUserData>(() => FetchUserData(getIt()));
  getIt.registerLazySingleton<RefreshSession>(() => RefreshSession(getIt()));

  // تسجيل LogInBloc
  getIt.registerFactory<LogInBloc>(
    () => LogInBloc(
      loginUser: getIt(),
      fetchUserData: getIt(),
      refreshSession: getIt(),
    ),
  );
}
