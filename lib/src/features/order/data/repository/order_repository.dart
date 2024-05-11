import 'package:dio/dio.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/api/api_consumer.dart';
import 'package:pharmacy_hub/src/features/cart/data/models/cart_model.dart';
import 'package:pharmacy_hub/src/features/order/data/models/address_model.dart';
import 'package:pharmacy_hub/src/features/order/data/models/delivery_method_model.dart';
import 'package:pharmacy_hub/src/features/order/data/models/my_order_model.dart';
import 'package:pharmacy_hub/src/features/order/data/models/order_params.dart';

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

  Future<AddressModel> updateAddress({required AddressModel model}) async {
    final Response response = await _apiConsumer.put(
      ApiConstant.address,
      body: model.toMap(),
    );
    return AddressModel.fromMap(response.data);
  }

  Future<String> createPaymentIntent({required String cartId}) async {
    final Response response = await _apiConsumer.post(
      '${ApiConstant.payment}/$cartId',
    );
    return response.data['clientSecret'];
  }

  Future<void> createOrder({required OrderParamsBody body}) async {
    await _apiConsumer.post(
      ApiConstant.orders,
      body: body.toMap(),
    );
  }

  Future<List<MyOrdersModel>> getMyOrders() async {
    final Response response = await _apiConsumer.get(ApiConstant.orders);
    return List<MyOrdersModel>.from(
      ((response.data).map((x) => MyOrdersModel.fromMap(x))),
    );
  }
}
