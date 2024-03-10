import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/resources/theme/app_light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      builder: (context, Widget? child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: getAppTheme(),
          themeMode: ThemeMode.light,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}