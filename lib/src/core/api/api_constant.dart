import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static const String baseUrl = 'http://e-pharmacy.runasp.net/';

  static const String medicine = 'api/product?CategoryId=1';
  static const String vitamins = 'api/product?CategoryId=2';
  static const String equipments = 'api/product?CategoryId=3';
  static const String cares = 'api/product?CategoryId=4';
  static const String categories = 'api/product/Categories';



  /// TODO  payment keys
  static String STRIPE_SECRET_KEY = dotenv.env['STRIPE_SECRET_KEY']!;
  static String STRIPE_PUBLISHABLE_KEY = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  static String PAYPAL_CLIENT_ID = dotenv.env['PAYPAL_CLIENT_ID']!;
  static String PAYPAL_SECRET_KEY = dotenv.env['PAYPAL_SECRET_KEY']!;
}
