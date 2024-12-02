part of 'todo_bloc_bloc.dart';

sealed class TodoBlocState extends Equatable {
  const TodoBlocState();

  @override
  List<Object> get props => [];
}

final class TodoBlocInitial extends TodoBlocState {}

final class TodoLoadingState extends TodoBlocState {}

final class TodosLoadedState extends TodoBlocState {
  final List<Todo> todos;

  const TodosLoadedState({required this.todos});

  @override
  List<Object> get props => [todos];
}

final class TodoLoadedState extends TodoBlocState {
  final Todo todo;

  const TodoLoadedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class TodoAddedState extends TodoBlocState {
  final Todo todo;

  const TodoAddedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class TodoUpdatedState extends TodoBlocState {
  final Todo todo;

  const TodoUpdatedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class TodoDeletedState extends TodoBlocState {
  final int id;

  const TodoDeletedState({required this.id});

  @override
  List<Object> get props => [id];
}

final class RandomTodoLoadedState extends TodoBlocState {
  final Todo todo;

  const RandomTodoLoadedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class TodoErrorState extends TodoBlocState {
  final String message;

  const TodoErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
