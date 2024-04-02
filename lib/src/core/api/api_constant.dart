import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static const String baseUrl = 'https://so2023.sos.org.sa/wp-json/custom/v1';

  static String STRIPE_SECRET_KEY = dotenv.env['STRIPE_SECRET_KEY']!;
  static String STRIPE_PUBLISHABLE_KEY = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  static String PAYPAL_CLIENT_ID = dotenv.env['PAYPAL_CLIENT_ID']!;
  static String PAYPAL_SECRET_KEY = dotenv.env['PAYPAL_SECRET_KEY']!;
}
