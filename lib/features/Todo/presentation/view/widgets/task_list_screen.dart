import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/Todo/presentation/view/widgets/add_task_screen.dart';

import '../../bloc/todo_bloc/todo_bloc_bloc.dart';
import 'task_card.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO APP'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<TodoBlocBloc>().add(RefreshTodosEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<TodoBlocBloc, TodoBlocState>(
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodosLoadedState) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return TaskCard(
                  title: todo.todo,
                  subtitle: 'User ID: ${todo.userId}',
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddTaskScreen(todo: todo), // تمرير المهمة
                      ),
                    );
                  },
                  onDelete: () {
                    context
                        .read<TodoBlocBloc>()
                        .add(DeleteTodoEvent(id: todo.id));
                  },
                  onComplete: () {
                    // وضع المهام في حالة مكتملة
                    context.read<TodoBlocBloc>().add(UpdateTodoEvent(
                        todo: todo.copyWith(completed: true))); // اكتمال المهمة
                  },
                );
              },
            );
          } else if (state is TodoErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No tasks available.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTask');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
