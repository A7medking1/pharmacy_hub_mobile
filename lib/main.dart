import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmacy_hub/my_app.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/features/cart/data/models/cart_model.dart';
import 'package:pharmacy_hub/src/features/cart/data/repository/cart_repository_local.dart';
import 'package:pharmacy_hub/src/features/favorites/data/local_repository/local_repository.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Bloc.observer = MyBlocObserver();

  Stripe.publishableKey = ApiConstant.STRIPE_PUBLISHABLE_KEY;

  await Stripe.instance.applySettings();

  await Hive.initFlutter();

  registerAdapter();

  await Future.wait([
    Hive.openBox(favoriteBoxName),
    Hive.openBox(cartBoxName),
  ]);

  await ServicesLocator().init();

  FlutterNativeSplash.remove();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());

 /* runApp(DevicePreview(
    builder: (BuildContext context) => const MyApp(),
  ));*/
}

void registerAdapter() {
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CartItemAdapter());
}
