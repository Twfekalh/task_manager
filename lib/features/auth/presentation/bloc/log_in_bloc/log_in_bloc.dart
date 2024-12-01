import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/auth/domain/entities/user_entites.dart';
import 'package:task_manager/features/auth/domain/use_case/fetch_user_usecase.dart';
import 'package:task_manager/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:task_manager/features/auth/domain/use_case/refresh_session_usecase.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final LoginUser loginUser;
  final FetchUserData fetchUserData;
  final RefreshSession refreshSession;

  LogInBloc({
    required this.loginUser,
    required this.fetchUserData,
    required this.refreshSession,
  }) : super(LogInInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<FetchUserDataEvent>(_onFetchUserData);
    on<RefreshSessionEvent>(_onRefreshSession);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LogInState> emit,
  ) async {
    emit(LogInLoading());
    final failureOrUser =
        await loginUser.execute(event.username, event.password);
    emit(_mapFailureOrUserToState(failureOrUser));
  }

  Future<void> _onFetchUserData(
    FetchUserDataEvent event,
    Emitter<LogInState> emit,
  ) async {
    emit(LogInLoading());
    final failureOrUser = await fetchUserData.execute(event.accessToken);
    emit(_mapFailureOrUserToState(failureOrUser));
  }

  Future<void> _onRefreshSession(
    RefreshSessionEvent event,
    Emitter<LogInState> emit,
  ) async {
    emit(LogInLoading());
    final failureOrUser = await refreshSession.execute(event.refreshToken);
    emit(_mapFailureOrUserToState(failureOrUser));
  }

  LogInState _mapFailureOrUserToState(Either<Failure, User> either) {
    return either.fold(
      (failure) => LogInFailure(errorMessage: _mapFailureToMessage(failure)),
      (user) => LogInSuccess(
        accessToken: user.accessToken,
        refreshToken: user.refreshToken,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Server Failure. Please try again later.";
      case OfflineFailure:
        return "No Internet Connection.";
      case AuthenticationFailure:
        return "Authentication failed. Please check your credentials.";
      default:
        return "Unexpected Error, Please try again later.";
    }
  }
}
