import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/errors/failure.dart';
import 'package:task_manager/features/auth/domain/entities/user_entites.dart';
import 'package:task_manager/features/auth/domain/use%20case/login_user%20_UseCase.dart';
import '../../../domain/use case/fetch_user_UseCase.dart';
import '../../../domain/use case/refresh_session_UseCase.dart';
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
      LoginButtonPressed event, Emitter<LogInState> emit) async {
    emit(LogInLoading());

    final failureOrUser =
        await loginUser.execute(event.username, event.password);

    failureOrUser.fold(
      (failure) =>
          emit(LogInFailure(errorMessage: _mapFailureToMessage(failure))),
      (user) => emit(LogInSuccess(
          accessToken: user.accessToken, refreshToken: user.refreshToken)),
    );
  }

  Future<void> _onFetchUserData(
      FetchUserDataEvent event, Emitter<LogInState> emit) async {
    emit(LogInLoading());

    final failureOrUser = await fetchUserData.execute(event.accessToken);

    failureOrUser.fold(
      (failure) =>
          emit(LogInFailure(errorMessage: _mapFailureToMessage(failure))),
      (user) => emit(LogInSuccess(
          accessToken: user.accessToken, refreshToken: user.refreshToken)),
    );
  }

  Future<void> _onRefreshSession(
      RefreshSessionEvent event, Emitter<LogInState> emit) async {
    emit(LogInLoading());

    final failureOrUser = await refreshSession.execute(event.refreshToken);

    failureOrUser.fold(
      (failure) =>
          emit(LogInFailure(errorMessage: _mapFailureToMessage(failure))),
      (user) => emit(LogInSuccess(
          accessToken: user.accessToken, refreshToken: user.refreshToken)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return "An unexpected error occurred. Please try again.";
  }
}
