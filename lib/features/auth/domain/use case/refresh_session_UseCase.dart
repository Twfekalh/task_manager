import 'package:dartz/dartz.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/auth/domain/entities/user_entites.dart';
import 'package:task_manager/features/auth/domain/repositories/user_repositories.dart';

class RefreshSession {
  final UserRepository repository;

  RefreshSession(this.repository);

  Future<Either<Failure, User>> execute(String refreshToken) async {
    return await repository.refreshSession(refreshToken);
  }
}
