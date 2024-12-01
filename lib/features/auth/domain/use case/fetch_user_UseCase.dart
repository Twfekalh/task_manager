import 'package:task_manager/features/auth/domain/entities/user_entites.dart';
import 'package:task_manager/features/auth/domain/repositories/user_repositories.dart';

class FetchUserData {
  final UserRepository repository;

  FetchUserData(this.repository);

  Future<User> execute(String accessToken) async {
    return await repository.fetchUserData(accessToken);
  }
}
