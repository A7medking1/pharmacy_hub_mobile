import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/login/login_screen.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/signup/sign_up_screen.dart';
import 'package:pharmacy_hub/src/features/home/ui/home.dart';

class Routes {
  Routes._();

  static const splash = '/';
  static const login = 'login';
  static const signUp = 'signUp';
  static const home = 'home';
}

class _RouterPath {
  _RouterPath._();

  static const splash = '/';
  static const login = '/login';
  static const signUp = '/signUp';
  static const home = '/home';
}

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: Routes.splash,
        path: _RouterPath.splash,
        builder: (_, state) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const LogInScreen(),
        ),
      ),
      GoRoute(
        name: Routes.signUp,
        path: _RouterPath.signUp,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        name: Routes.home,
        path: _RouterPath.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
