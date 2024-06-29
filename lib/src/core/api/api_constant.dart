import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  //static const String baseUrl = 'https://e-pharmacy.runasp.net/';
  static const String baseUrl =
     'https://e-pharmacyhub-edarcdhhakcaeaad.eastus-01.azurewebsites.net/';

  static const String login = 'api/Account/Login';
  static const String register = 'api/Account/Register';
  static const String account = 'api/Account';
  static const String address = 'api/Account/Address';
  static const String editAccount = 'api/Account/EditAccount';
  static const String changePassword = 'api/Account/ChangePassword';
  static const String product = 'api/product';
  static const String categories = 'api/product/Categories';
  static const String cart = 'api/Basket';
  static const String orders = 'api/Orders';
  static const String delivery = 'api/Orders/DeliveryMethods';
  static const String payment = 'api/Payments';
  static const String chatAi = 'api/Gemini/Text';

  /// TODO  payment keys
  static String STRIPE_SECRET_KEY = dotenv.env['STRIPE_SECRET_KEY']!;
  static String STRIPE_PUBLISHABLE_KEY = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
}
