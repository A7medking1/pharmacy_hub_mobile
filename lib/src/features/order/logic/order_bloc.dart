import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/error/exceptions.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/features/cart/data/models/cart_model.dart';
import 'package:pharmacy_hub/src/features/cart/data/repository/cart_repository_local.dart';
import 'package:pharmacy_hub/src/features/order/data/models/delivery_method_model.dart';
import 'package:pharmacy_hub/src/features/order/data/repository/order_repository.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc(this._repository) : super(const OrderState()) {
    on<GetDeliveryMethodsEvent>(_getDeliveryMethods);
    on<ChangeDeliveryMethodEvent>(_changeDeliveryMethod);
    on<AddDeliveryMethodEvent>(_addDeliveryMethod);
  }

  final OrderRepository _repository;
  final CartLocalRepository _cartLocalRepository = CartLocalRepositoryImpl();

  FutureOr<void> _getDeliveryMethods(
      GetDeliveryMethodsEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(getDeliveryReqState: ReqState.loading));
    try {
      final List<DeliveryMethodsModel> deliveryMethods =
          await _repository.getDeliveryMethods();
      // deliveryMethods.sort((a, b) => a.cost.compareTo(b.cost));
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
}
