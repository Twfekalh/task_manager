import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/locator/locator.dart'; // Import locator.dart
import 'package:task_manager/core/theme/app_theme.dart';
import 'package:task_manager/core/utils/app_string.dart';
import 'package:task_manager/core/routers/routers.dart';

import 'features/Todo/presentation/bloc/todo_bloc/todo_bloc_bloc.dart';
import 'features/auth/presentation/bloc/log_in_bloc/log_in_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setuplocator(); // Initialize the locator
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<LogInBloc>(), // Correct way to access LogInBloc
        ),
        BlocProvider(
          create: (context) =>
              sl<TodoBlocBloc>() // Correct way to access TodoBloc
                ..add(const GetAllTodosEvent(skip: 0, limit: 10)),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppString.appName,
        theme: AppTheme.darkThemeMode,
        routerConfig: router,
      ),
    );
  }
}
