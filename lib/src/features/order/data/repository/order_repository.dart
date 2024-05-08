import 'package:dio/dio.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/api/api_consumer.dart';
import 'package:pharmacy_hub/src/features/cart/data/models/cart_model.dart';
import 'package:pharmacy_hub/src/features/order/data/models/delivery_method_model.dart';

class OrderRepository {
  final ApiConsumer _apiConsumer;

  const OrderRepository(this._apiConsumer);

  Future<List<DeliveryMethodsModel>> getDeliveryMethods() async {
    final Response response = await _apiConsumer.get(ApiConstant.delivery);
    return List<DeliveryMethodsModel>.from(
      ((response.data).map((x) => DeliveryMethodsModel.fromMap(x))),
    );
  }

  Future<void> addDeliveryMethodToBasket({required CartModel cartModel}) async {
    await _apiConsumer.post(
      ApiConstant.cart,
      body: cartModel.toMap(),
    );
  }
}
