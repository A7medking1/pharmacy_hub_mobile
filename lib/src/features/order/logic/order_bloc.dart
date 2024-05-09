import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/error/exceptions.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/payment_service/stripe/stripe_services.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/features/auth/data/models/userModel.dart';
import 'package:pharmacy_hub/src/features/cart/data/models/cart_model.dart';
import 'package:pharmacy_hub/src/features/cart/data/repository/cart_repository_local.dart';
import 'package:pharmacy_hub/src/features/order/data/models/address_model.dart';
import 'package:pharmacy_hub/src/features/order/data/models/delivery_method_model.dart';
import 'package:pharmacy_hub/src/features/order/data/models/order_params.dart';
import 'package:pharmacy_hub/src/features/order/data/repository/order_repository.dart';
import 'package:pharmacy_hub/src/features/profile/logic/profile_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this._repository) : super(const OrderState()) {
    on<GetDeliveryMethodsEvent>(_getDeliveryMethods);
    on<ChangeDeliveryMethodEvent>(_changeDeliveryMethod);
    on<AddDeliveryMethodEvent>(_addDeliveryMethod);
    on<UpdateAddressEvent>(_updateAddress);
    on<GetPaymentIntentEvent>(_getPaymentIntent);
  }

  final OrderRepository _repository;
  final CartLocalRepository _cartLocalRepository = CartLocalRepositoryImpl();

  //String clientSecret = '';

  FutureOr<void> _getDeliveryMethods(
      GetDeliveryMethodsEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(getDeliveryReqState: ReqState.loading));
    try {
      final List<DeliveryMethodsModel> deliveryMethods =
          await _repository.getDeliveryMethods();
      emit(
        state.copyWith(
          getDeliveryReqState: ReqState.success,
          deliveryMethods: deliveryMethods,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          getDeliveryReqState: ReqState.error,
          errorMessage: e.errorMessageModel?.statusMessage ?? '',
        ),
      );
    }
  }

  FutureOr<void> _changeDeliveryMethod(
      ChangeDeliveryMethodEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(selectedDeliveryMethod: event.index));

    log(event.index.getMethodId.toString());
  }

  FutureOr<void> _addDeliveryMethod(
      AddDeliveryMethodEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(addDeliveryMethodReqState: ReqState.loading));

    final String userId = sl<AppPreferences>().getUser().id;
    List<CartItem> cartItems = await _cartLocalRepository.getCarts();

    CartModel cartModel = CartModel(
      id: userId,
      items: cartItems,
      deliveryMethodId: state.selectedDeliveryMethod.getMethodId,
    );

    log('new cart model $cartModel');

    try {
      await _repository.addDeliveryMethodToBasket(cartModel: cartModel);
      emit(
        state.copyWith(
          addDeliveryMethodReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          addDeliveryMethodReqState: ReqState.error,
          errorMessage: e.errorMessageModel?.statusMessage ?? '',
        ),
      );
    }
  }

  FutureOr<void> _updateAddress(
      UpdateAddressEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(updateAddressReqState: ReqState.loading));

    try {
      final AddressModel addressModel = await _repository.updateAddress(
        model: event.addressModel,
      );

      UserModel userModel = sl<AppPreferences>().getUser();
      await sl<AppPreferences>().setUser(
        userModel.copyWith(
          street: addressModel.street,
          city: addressModel.city,
        ),
      );

      UserModel updatedUser = sl<AppPreferences>().getUser();

      log('updatedUser $updatedUser');

      emit(
        state.copyWith(
          updateAddressReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          updateAddressReqState: ReqState.error,
          errorMessage: e.errorMessageModel?.statusMessage ?? '',
        ),
      );
    }
  }

  Future<void> createOrder() async {
    final UserModel user = sl<AppPreferences>().getUser();

    await _repository.createOrder(
      body: OrderParamsBody(
        basketId: user.id,
        deliveryMethodId: state.selectedDeliveryMethod.getMethodId,
        shippingAddress: ShippingAddress(
          street: user.street,
          city: user.city,
        ),
      ),
    );
  }

  Future<void> makePayment(String clientSecret) async {
    //  try {
    await StripServices().makePayment(clientSecret);
    //  } catch (e) {
    // showToastProfile('Something went wrong!!', Colors.red);
    // }
  }

  FutureOr<void> _getPaymentIntent(
      GetPaymentIntentEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(getPaymentIntentReqState: ReqState.loading));

    try {
      final String paymentIntentModel = await _repository.createPaymentIntent(
        cartId: sl<AppPreferences>().getUser().id,
      );

      await makePayment(paymentIntentModel);
      await createOrder();

      log('Payment successful');

      emit(
        state.copyWith(
          getPaymentIntentReqState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      showToastProfile('Something went wrong!!', Colors.red);
      emit(state.copyWith(
        getPaymentIntentReqState: ReqState.error,
      ));
    }
  }
}
