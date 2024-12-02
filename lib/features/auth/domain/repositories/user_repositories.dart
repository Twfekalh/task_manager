import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/auth/domain/entities/user_entites.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> loginUser(String username, String password);
  Future<Either<Failure, User>> fetchUserData(String accessToken);
  Future<Either<Failure, User>> refreshSession(String refreshToken);
}
