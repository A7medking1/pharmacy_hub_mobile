part of 'order_bloc.dart';

class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class GetDeliveryMethodsEvent extends OrderEvent {}

class ChangeDeliveryMethodEvent extends OrderEvent {
  final int index;

  const ChangeDeliveryMethodEvent({required this.index});
}

class AddDeliveryMethodEvent extends OrderEvent {

  const AddDeliveryMethodEvent();
}
