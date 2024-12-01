part of 'log_in_bloc.dart';

sealed class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LogInEvent {
  final String username;
  final String password;

  const LoginButtonPressed({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class FetchUserDataEvent extends LogInEvent {
  final String accessToken;

  const FetchUserDataEvent({required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}

class RefreshSessionEvent extends LogInEvent {
  final String refreshToken;

  const RefreshSessionEvent({required this.refreshToken});

  @override
  List<Object> get props => [refreshToken];
}
