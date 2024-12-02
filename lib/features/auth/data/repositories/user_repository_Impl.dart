// lib/features/auth/data/repositories/user_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/auth/data/data%20sources/local_user_data_source.dart';
import 'package:task_manager/features/auth/data/data%20sources/remote_data_source.dart';
import 'package:task_manager/features/auth/domain/entities/user_entites.dart';

import 'package:task_manager/features/auth/domain/repositories/user_repositories.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final LocalUserDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> loginUser(
      String username, String password) async {
    try {
      final user = await remoteDataSource.loginUser(username, password);
      await localDataSource.saveUserData(user);
      return Right(user); // إذا كانت العملية ناجحة
    } catch (error) {
      return Left(ServerFailure(error.toString())); // في حالة الفشل
    }
  }

  @override
  Future<Either<Failure, User>> fetchUserData(String accessToken) async {
    try {
      final user = await remoteDataSource.fetchUserData(accessToken);
      return Right(user); // إذا كانت العملية ناجحة
    } catch (error) {
      return Left(
          ServerFailure('Failed to fetch user data: ${error.toString()}'));
    }
  }

  @override
  Future<Either<Failure, User>> refreshSession(String refreshToken) async {
    try {
      final user = await remoteDataSource.refreshSession(refreshToken);
      await localDataSource.saveUserData(user);
      return Right(user); // إذا كانت العملية ناجحة
    } catch (error) {
      return Left(
          ServerFailure('Failed to refresh session: ${error.toString()}'));
    }
  }
}
