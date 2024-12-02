part of 'todo_bloc_bloc.dart';

sealed class TodoBlocEvent extends Equatable {
  const TodoBlocEvent();

  @override
  List<Object> get props => [];
}

class GetAllTodosEvent extends TodoBlocEvent {
  final int skip;
  final int limit;

  const GetAllTodosEvent({required this.skip, required this.limit});

  @override
  List<Object> get props => [skip, limit];
}

class GetTodoByIdEvent extends TodoBlocEvent {
  final int id;

  const GetTodoByIdEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class AddTodoEvent extends TodoBlocEvent {
  final Todo todo;

  const AddTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodoEvent extends TodoBlocEvent {
  final Todo todo;

  const UpdateTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends TodoBlocEvent {
  final int id;

  const DeleteTodoEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetRandomTodoEvent extends TodoBlocEvent {}

class RefreshTodosEvent extends TodoBlocEvent {}
