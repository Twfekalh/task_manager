import 'package:task_manager/features/auth/domain/entities/user_entites.dart';
import 'package:task_manager/features/auth/domain/repositories/user_repositories.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<User> execute(String username, String password) async {
    return await repository.loginUser(username, password);
  }
}
