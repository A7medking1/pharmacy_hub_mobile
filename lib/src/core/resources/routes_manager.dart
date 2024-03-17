import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/features/layout/logic/app_layout_bloc.dart';
import 'package:pharmacy_hub/src/features/layout/ui/app_layout.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/login/login_screen.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/signup/sign_up_screen.dart';
import 'package:pharmacy_hub/src/features/onBoarding/ui/onBoarding_screen.dart';
import 'package:pharmacy_hub/src/features/profile/logic/profile_bloc.dart';

class Routes {
  Routes._();

  static const splash = '/';
  static const login = 'login';
  static const signUp = 'signUp';
  static const appLayOut = 'AppLayOut';
}

class _RouterPath {
  _RouterPath._();

  static const splash = '/';
  static const login = '/login';
  static const signUp = '/signUp';
  static const appLayOut = '/AppLayOut';
}

class AppRouter {
  static final AppPreferences _preferences = sl<AppPreferences>();

  static GoRouter router = GoRouter(
    initialLocation: _RouterPath.splash,
    routes: [
      GoRoute(
        name: Routes.splash,
        path: _RouterPath.splash,
        redirect: (context, state) {
          final isOnBoardingCompleted = _preferences.isOnBoardingInPrefs();
          // If user has not completed onboarding, redirect to onboarding screen
          if (!isOnBoardingCompleted) {
            return _RouterPath.splash;
          }
          // If user has completed onboarding and tries to navigate to the splash screen, redirect to login
          if (isOnBoardingCompleted) {
            return _RouterPath.login;
          }
          // No redirect needed
          return null;
        },
        builder: (_, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        name: Routes.login,
        path: _RouterPath.login,
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

      /*
              pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const AppLayOut(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Change the opacity of the screen using a Curve based on the the animation's value
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
            },
          );
        },

      */
      /// The Code Above Make AppLayoutBloc Does Not Work So I Removed It
      GoRoute(
        name: Routes.appLayOut,
        path: _RouterPath.appLayOut,
        builder: (context, state) => BlocProvider(
          create: (context) => AppLayoutBloc(),
          child: const AppLayOut(),
        ),
      ),
    ],
  );
}
