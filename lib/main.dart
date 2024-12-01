import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_theme.dart';
import 'package:task_manager/core/utils/app_string.dart';

import 'core/routers/routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      theme: AppTheme.darkThemeMode,
      routerConfig: router,
    );
  }
}
