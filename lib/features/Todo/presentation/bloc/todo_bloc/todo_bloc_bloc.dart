import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entaties/todo_entities.dart';
import '../../../domain/usecase/Add_Todo_UseCase.dart';
import '../../../domain/usecase/Delete_Todo_UseCase.dart';
import '../../../domain/usecase/Get_Random_Todo_UseCase.dart';
import '../../../domain/usecase/Update_Todo_UseCase.dart';
import '../../../domain/usecase/get_todo_by_id_usecase.dart';
import '../../../domain/usecase/get_todos_usecase.dart';

part 'todo_bloc_event.dart';
part 'todo_bloc_state.dart';

class TodoBlocBloc extends Bloc<TodoBlocEvent, TodoBlocState> {
  final GetTodosUseCase getAllTodos;
  final GetTodoByIdUseCase getTodoById;
  final AddTodoUseCase addTodo;
  final UpdateTodoUseCase updateTodo;
  final DeleteTodoUseCase deleteTodo;
  final GetRandomTodoUseCase getRandomTodo;

  TodoBlocBloc({
    required this.getAllTodos,
    required this.getTodoById,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
    required this.getRandomTodo,
  }) : super(TodoBlocInitial()) {
    // Handling GetAllTodosEvent
    on<GetAllTodosEvent>((event, emit) async {
      emit(TodoLoadingState());

      final result = await getAllTodos(skip: event.skip, limit: event.limit);
      result.fold(
        (failure) =>
            emit(TodoErrorState(message: _mapFailureToMessage(failure))),
        (todos) => emit(TodosLoadedState(todos: todos)),
      );
    });

    on<GetTodoByIdEvent>((event, emit) async {
      emit(TodoLoadingState());
      final result = await getTodoById(event.id);
      result.fold(
        (failure) =>
            emit(TodoErrorState(message: _mapFailureToMessage(failure))),
        (todo) => emit(TodoLoadedState(todo: todo)),
      );
    });

    on<AddTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      final result = await addTodo(event.todo);
      result.fold(
        (failure) =>
            emit(TodoErrorState(message: _mapFailureToMessage(failure))),
        (todo) => emit(TodoAddedState(todo: todo)),
      );
    });

    on<UpdateTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      final result = await updateTodo(event.todo);
      result.fold(
        (failure) =>
            emit(TodoErrorState(message: _mapFailureToMessage(failure))),
        (todo) => emit(TodoUpdatedState(todo: todo)),
      );
    });

    on<DeleteTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      final result = await deleteTodo(event.id);
      result.fold(
        (failure) =>
            emit(TodoErrorState(message: _mapFailureToMessage(failure))),
        (_) => emit(TodoDeletedState(id: event.id)),
      );
    });

    on<GetRandomTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      final result = await getRandomTodo();
      result.fold(
        (failure) =>
            emit(TodoErrorState(message: _mapFailureToMessage(failure))),
        (todo) => emit(RandomTodoLoadedState(todo: todo)),
      );
    });

    on<RefreshTodosEvent>((event, emit) async {
      emit(TodoLoadingState());

      final result = await getAllTodos(skip: 0, limit: 10);
      result.fold(
        (failure) =>
            emit(TodoErrorState(message: _mapFailureToMessage(failure))),
        (todos) => emit(TodosLoadedState(todos: todos)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure. Please try again later.';
      default:
        return 'Unexpected error occurred.';
    }
  }
}
