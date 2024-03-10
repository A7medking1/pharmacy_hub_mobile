import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/features/auth/ui/login_screen.dart';

class Routes {
  Routes._();

  static const splash = '/';
  static const login = 'login';
}

class _RouterPath {
  _RouterPath._();

  static const splash = '/';
  static const login = '/login';
}

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: Routes.splash,
        path: _RouterPath.splash,
        builder: (_, state) => const LogInScreen(),
      ),

      /*     GoRoute(
        name: Routes.sessionsSubScreen,
        path: _RouterPath.sessionsSubScreen,
        builder: (_, state) => SessionsSubScreen(
          subCategory: state.extra as List<HomeSubcategories>,
        ),
      ),*/
/*      GoRoute(
        name: Routes.sessionsScreen,
        path: _RouterPath.sessionsScreen,
        builder: (_, state) => SessionsScreen(
          parameters: state.extra as FuckenSessionScreenParameters,
        ),
      ),*/
    ],
  );
}
