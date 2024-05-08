import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static const String baseUrl = 'https://e-pharmacy.runasp.net/';

  static const String login = 'api/Account/Login';
  static const String register = 'api/Account/Register';
  static const String account = 'api/Account';
  static const String editAccount = 'api/Account/EditAccount';
  static const String changePassword = 'api/Account/ChangePassword';
  static const String product = 'api/product';
  static const String categories = 'api/product/Categories';
  static const String cart = 'api/Basket';

  static const String orders = 'api/Orders';
  static const String delivery = 'api/Orders/DeliveryMethods';
  static const String payment = 'api/Payment';

  /// TODO  payment keys
  static String STRIPE_SECRET_KEY = dotenv.env['STRIPE_SECRET_KEY']!;
  static String STRIPE_PUBLISHABLE_KEY = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  static String PAYPAL_CLIENT_ID = dotenv.env['PAYPAL_CLIENT_ID']!;
  static String PAYPAL_SECRET_KEY = dotenv.env['PAYPAL_SECRET_KEY']!;
}
