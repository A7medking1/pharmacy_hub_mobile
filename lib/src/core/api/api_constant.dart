import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pharmacy_hub/src/features/home/data/repository/repository.dart';

class ApiConstant {
  static const String baseUrl = 'http://e-pharmacy.runasp.net/';

  static const String login = 'api/Account/Login';
  static const String register = 'api/Account/Register';

  static const String product = 'api/product';
  static const String editAccount = 'api/Account/EditAccount';
  static const String changePassword = 'api/Account/ChangePassword';

  static String cart = 'api/Basket';

  static String productsByCategory(int categoryId) =>
      'api/product?CategoryId=${categoryId.toString()}';

  static const String categories = 'api/product/Categories';

  static String medicineAlternative({
    required AlternativeProductParams params,
  }) =>
      'api/product?CategoryId=${params.categoryId}&ActiveIngredientId=${params.activeIngredientId}&page=${params.page}&productId=${params.productId}';

  static String medicineSimilar({
    required SimilarProductParams params,
  }) =>
      'api/product?CategoryId=${params.categoryId}&DiseaseId=${params.diseaseId}&page=${params.page}&productId=${params.productId}';

  /// TODO  payment keys
  static String STRIPE_SECRET_KEY = dotenv.env['STRIPE_SECRET_KEY']!;
  static String STRIPE_PUBLISHABLE_KEY = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  static String PAYPAL_CLIENT_ID = dotenv.env['PAYPAL_CLIENT_ID']!;
  static String PAYPAL_SECRET_KEY = dotenv.env['PAYPAL_SECRET_KEY']!;
}
