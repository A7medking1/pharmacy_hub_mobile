import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/resources/theme/app_light_theme.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';
import 'package:pharmacy_hub/src/features/favorites/logic/favorite_bloc.dart';
import 'package:pharmacy_hub/src/features/home/logic/home_bloc.dart';
import 'package:pharmacy_hub/src/features/profile/logic/profile_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<HomeBloc>()
                ..add(GetCategoriesEvent())
                ..add(GetMedicineEvent())
                ..add(GetVitaminsEvent())
                ..add(GetEquipmentsEvent())
                ..add(GetCaresEvent()),
            ),
            BlocProvider(
              create: (context) =>
                  FavoriteBloc()..add(GetFavoritesItemsEvent()),
            ),
            BlocProvider(
              create: (context) => sl<ProfileBloc>(),
            ),
            BlocProvider(
              create: (context) => sl<CartBloc>(),
            ),
          ],
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              themeMode: ThemeMode.light,
              theme: getAppTheme(),
              routerConfig: AppRouter.router,
            ),
          ),
        );
      },
    );
  }
}
