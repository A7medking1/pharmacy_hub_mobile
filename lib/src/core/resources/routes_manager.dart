import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/features/auth/logic/auth_bloc.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/login/login_screen.dart';
import 'package:pharmacy_hub/src/features/auth/ui/screen/signup/sign_up_screen.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/cart_screen.dart';
import 'package:pharmacy_hub/src/features/cart/ui/map_screen.dart';
import 'package:pharmacy_hub/src/features/cart/ui/success_payment.dart';
import 'package:pharmacy_hub/src/features/favorites/ui/favorites_screen.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';
import 'package:pharmacy_hub/src/features/home/ui/all_product_screen.dart';
import 'package:pharmacy_hub/src/features/home/ui/product_details_screen.dart';
import 'package:pharmacy_hub/src/features/layout/logic/app_layout_bloc.dart';
import 'package:pharmacy_hub/src/features/layout/ui/app_layout.dart';
import 'package:pharmacy_hub/src/features/onBoarding/ui/onBoarding_screen.dart';
import 'package:pharmacy_hub/src/features/profile/ui/about_screen.dart';
import 'package:pharmacy_hub/src/features/profile/ui/contact_us_screen.dart';

import '../../features/home/logic/search_bloc/search_bloc.dart';
import '../../features/home/ui/search_screen.dart';
import '../../features/profile/logic/profile_bloc.dart';
import '../../features/profile/ui/account_screen.dart';

class Routes {
  Routes._();

  static const splash = '/';
  static const login = 'login';
  static const signUp = 'signUp';
  static const appLayOut = 'appLayOut';
  static const cart = 'cart';
  static const about = 'about';
  static const contactUs = 'contact-us';
  static const map = 'map';
  static const account = 'account';
  static const successPayment = 'successPayment';
  static const productDetails = 'productDetails';
  static const allProduct = 'allProduct';
  static const favScreen = 'favScreen';
  static const search = 'search';
}

class _RouterPath {
  _RouterPath._();

  static const splash = '/';
  static const login = '/login';
  static const signUp = '/signUp';
  static const appLayOut = '/appLayOut';
  static const cart = '/cart';
  static const about = '/about';
  static const contactUs = '/contact-us';
  static const map = '/map';
  static const account = '/account';
  static const successPayment = '/successPayment';
  static const allProduct = '/allProduct';
  static const productDetails = '/productDetails';
  static const favScreen = '/favScreen';
  static const search = '/search';
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
      GoRoute(
        name: Routes.appLayOut,
        path: _RouterPath.appLayOut,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: BlocProvider(
              create: (context) => AppLayoutBloc(),
              child: const AppLayOut(),
            ),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Change the opacity of the screen using a Curve based on the the animation's value
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: Routes.cart,
        path: _RouterPath.cart,
        builder: (_, state) => BlocProvider(
          create: (context) => CartBloc(),
          child: const CartScreen(),
        ),
      ),
      GoRoute(
        name: Routes.about,
        path: _RouterPath.about,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<ProfileBloc>(),
          child: const AboutScreen(),
        ),
      ),
      GoRoute(
        name: Routes.contactUs,
        path: _RouterPath.contactUs,
        builder: (context, state) => const ContactUsScreen(),
      ),
      GoRoute(
        name: Routes.map,
        path: _RouterPath.map,
        builder: (context, state) => MapScreen(
          cartBloc: state.extra as CartBloc,
        ),
      ),
      GoRoute(
        name: Routes.account,
        path: _RouterPath.account,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<ProfileBloc>(),
          child: const AccountScreen(),
        ),
      ),
      GoRoute(
        name: Routes.successPayment,
        path: _RouterPath.successPayment,
        builder: (context, state) => const SuccessPaymentScreen(),
      ),
      GoRoute(
        name: Routes.productDetails,
        path: _RouterPath.productDetails,
        builder: (context, state) => ProductDetailsScreen(
          params: state.extra as ProductDetailsParams,
        ),
      ),
      GoRoute(
        name: Routes.allProduct,
        path: _RouterPath.allProduct,
        builder: (context, state) => AllProductScreen(
          params: state.extra as AllProductScreenParams,
        ),
      ),
      GoRoute(
        name: Routes.favScreen,
        path: _RouterPath.favScreen,
        builder: (context, state) => FavoritesScreen(),
      ),

      GoRoute(
        name: Routes.search,
        path: _RouterPath.search,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<SearchBloc>(),
          child: const SearchScreen(),
        ),
      ),

      //   name: Routes.search,
      //   path: _RouterPath.search,
      //   builder: (context, state) => BlocProvider(create: (context)=> sl<SearchBloc>(), child: const SearchScreen(),),
      // ),
    ],
  );
}

class ProductDetailsParams extends Equatable {
  final ProductModel productModel;

  final UniqueKey uniqueKey;

  final ProductType productType;
  final int itemIndex;

  // this for vitamins , equipment and cares  only because does not have similar or alternative ;
  final List<ProductModel> similar;

  const ProductDetailsParams({
    required this.productType,
    required this.productModel,
    required this.uniqueKey,
    required this.similar,
    this.itemIndex = -1,
  });

  @override
  List<Object> get props =>
      [productModel, uniqueKey, productType, similar, itemIndex];
}
