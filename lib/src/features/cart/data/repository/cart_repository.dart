import 'package:dio/dio.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/api/api_consumer.dart';
import 'package:pharmacy_hub/src/features/cart/data/models/cart_model.dart';

class CartRepository {
  final ApiConsumer _apiConsumer;

  const CartRepository(this._apiConsumer);

  Future<CartModel> getCart({required String cartId}) async {
    final Response response =
        await _apiConsumer.get(ApiConstant.cart, queryParameters: {
      'id': cartId,
    });
    return CartModel.fromMap(response.data);
  }

  Future<CartModel> addToCart({required CartModel cartModel}) async {
    final Response response = await _apiConsumer.post(
      ApiConstant.cart,
      body: cartModel.toMap(),
    );
    return CartModel.fromMap(response.data);
  }

  Future<void> deleteCart({required String cartId}) async {
    await _apiConsumer.delete(ApiConstant.cart, queryParameters: {
      'id': cartId,
    });
  }
}
