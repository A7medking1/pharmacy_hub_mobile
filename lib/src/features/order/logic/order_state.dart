part of 'order_bloc.dart';

class OrderState extends Equatable {
  final ReqState getDeliveryReqState;
  final String errorMessage;
  final List<DeliveryMethodsModel> deliveryMethods;
  final int selectedDeliveryMethod;
  final ReqState addDeliveryMethodReqState;
  final ReqState updateAddressReqState;
  final ReqState getPaymentIntentReqState;

  const OrderState({
    this.getDeliveryReqState = ReqState.empty,
    this.errorMessage = '',
    this.deliveryMethods = const [],
    this.selectedDeliveryMethod = 0,
    this.addDeliveryMethodReqState = ReqState.empty,
    this.updateAddressReqState = ReqState.empty,
    this.getPaymentIntentReqState = ReqState.empty,
  });

  OrderState copyWith({
    ReqState? getDeliveryReqState,
    String? errorMessage,
    List<DeliveryMethodsModel>? deliveryMethods,
    int? selectedDeliveryMethod,
    ReqState? addDeliveryMethodReqState,
    ReqState? updateAddressReqState,
    ReqState? getPaymentIntentReqState,
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
      getPaymentIntentReqState: getPaymentIntentReqState ?? this.getPaymentIntentReqState,
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
      ];
}
