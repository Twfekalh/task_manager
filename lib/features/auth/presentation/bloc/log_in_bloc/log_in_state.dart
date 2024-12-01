part of 'log_in_bloc.dart';

sealed class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object> get props => [];
}

final class LogInInitial extends LogInState {}

class LogInLoading extends LogInState {}

class LogInSuccess extends LogInState {
  final String accessToken;
  final String refreshToken;

  const LogInSuccess({required this.accessToken, required this.refreshToken});

  @override
  List<Object> get props => [accessToken, refreshToken];
}

class LogInFailure extends LogInState {
  final String errorMessage;

  const LogInFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
