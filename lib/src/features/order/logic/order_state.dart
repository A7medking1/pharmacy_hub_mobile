part of 'order_bloc.dart';

class OrderState extends Equatable {
  final ReqState getDeliveryReqState;
  final String errorMessage;
  final List<DeliveryMethodsModel> deliveryMethods;
  final int selectedDeliveryMethod;
  final ReqState addDeliveryMethodReqState;
  final ReqState updateAddressReqState;
  final ReqState getPaymentIntentReqState;

  ////
  final ReqState getMyOrdersReqState;

  final List<MyOrdersModel> myOrders;

  const OrderState({
    this.getDeliveryReqState = ReqState.empty,
    this.errorMessage = '',
    this.deliveryMethods = const [],
    this.selectedDeliveryMethod = 0,
    this.addDeliveryMethodReqState = ReqState.empty,
    this.updateAddressReqState = ReqState.empty,
    this.getPaymentIntentReqState = ReqState.empty,
    this.myOrders = const [],
    this.getMyOrdersReqState = ReqState.loading,
  });

  OrderState copyWith({
    ReqState? getDeliveryReqState,
    String? errorMessage,
    List<DeliveryMethodsModel>? deliveryMethods,
    int? selectedDeliveryMethod,
    ReqState? addDeliveryMethodReqState,
    ReqState? updateAddressReqState,
    ReqState? getPaymentIntentReqState,
    ReqState? getMyOrdersReqState,
    List<MyOrdersModel>? myOrders,
  }) {
    return OrderState(
      getDeliveryReqState: getDeliveryReqState ?? this.getDeliveryReqState,
      errorMessage: errorMessage ?? this.errorMessage,
      deliveryMethods: deliveryMethods ?? this.deliveryMethods,
      selectedDeliveryMethod:
          selectedDeliveryMethod ?? this.selectedDeliveryMethod,
      addDeliveryMethodReqState:
          addDeliveryMethodReqState ?? this.addDeliveryMethodReqState,
      updateAddressReqState:
          updateAddressReqState ?? this.updateAddressReqState,
      getPaymentIntentReqState:
          getPaymentIntentReqState ?? this.getPaymentIntentReqState,
      getMyOrdersReqState: getMyOrdersReqState ?? this.getMyOrdersReqState,
      myOrders: myOrders ?? this.myOrders,
    );
  }

  @override
  List<Object> get props => [
        getDeliveryReqState,
        errorMessage,
        deliveryMethods,
        selectedDeliveryMethod,
        addDeliveryMethodReqState,
        updateAddressReqState,
        getPaymentIntentReqState,
        getMyOrdersReqState,
        myOrders,

      ];

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
