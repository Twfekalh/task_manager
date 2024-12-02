import 'package:dartz/dartz.dart';
import 'package:task_manager/features/auth/domain/entities/user_entites.dart';
import 'package:task_manager/features/auth/domain/repositories/user_repositories.dart';

import '../../../../core/errors/failure.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, User>> execute(
      String username, String password) async {
    return await repository.loginUser(username, password);
  }
}
