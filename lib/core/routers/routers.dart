import 'package:go_router/go_router.dart';
import 'package:task_manager/core/routers/routers_names.dart';
import 'package:task_manager/features/Todo/presentation/view/todo_view.dart';
import 'package:task_manager/features/auth/presentation/view/login_view.dart';

import '../../features/splash/view/splash_view.dart';

// abstract class AppRouter {
//   static const kHomeView = '/Splash';

final GoRouter router = GoRouter(
  routes: [
    // GoRoute(
    //   name: RoutersNames.splash,
    //   path: '/',
    //   builder: (context, state) => const SplashView(),
    // ),
    // GoRoute(
    //   name: RoutersNames.login,
    //   path: "/login",
    //   builder: (context, state) => const LoginView(),
    // ),
    GoRoute(
      name: RoutersNames.todo,
      path: "/",
      builder: (context, state) => const TodoView(),
    ),
  ],
);
