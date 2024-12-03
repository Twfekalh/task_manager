import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entaties/todo_entities.dart';
import '../../bloc/todo_bloc/todo_bloc_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  final Todo? todo;

  const AddTaskScreen({Key? key, this.todo}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // إذا كان هناك مهمة قادمة من شاشة أخرى، نملأ الحقول بالقيم
    if (widget.todo != null) {
      _titleController.text = widget.todo!.todo; // العنوان
      _detailController.text = widget.todo!.details; // التفاصيل
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add/Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _detailController,
              decoration: const InputDecoration(labelText: 'Details'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final details = _detailController.text.trim();

                if (title.isNotEmpty && details.isNotEmpty) {
                  if (widget.todo != null) {
                    // إذا كانت هناك مهمة موجودة (التعديل)
                    final updatedTodo = widget.todo!.copyWith(
                      todo: title,
                      details: details,
                    );
                    context
                        .read<TodoBlocBloc>()
                        .add(UpdateTodoEvent(todo: updatedTodo));
                  } else {
                    // إذا كانت المهمة جديدة (الإضافة)
                    context.read<TodoBlocBloc>().add(AddTodoEvent(
                          todo: Todo(
                            id: 0,
                            todo: title,
                            details: details, // تفاصيل المهمة
                            completed: false,
                            userId: 1, // يمكنك تعديله بحسب الحاجة
                          ),
                        ));
                  }
                  Navigator.pop(context); // العودة إلى الشاشة السابقة
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All fields are required')),
                  );
                }
              },
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
