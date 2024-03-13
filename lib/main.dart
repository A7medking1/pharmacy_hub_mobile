import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pharmacy_hub/my_app.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc.observer = MyBlocObserver();

  await ServicesLocator().init();

  FlutterNativeSplash.remove();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}
