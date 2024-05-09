import 'package:equatable/equatable.dart';

class OrderParamsBody extends Equatable {
  final String basketId;
  final int deliveryMethodId;
  final ShippingAddress shippingAddress;

  const OrderParamsBody({
    required this.basketId,
    required this.deliveryMethodId,
    required this.shippingAddress,
  });

  factory OrderParamsBody.fromMap(Map<String, dynamic> json) => OrderParamsBody(
        basketId: json["basketId"],
        deliveryMethodId: json["deliveryMethodId"],
        shippingAddress: ShippingAddress.fromMap(json["shippingAddress"]),
      );

  Map<String, dynamic> toMap() => {
        "basketId": basketId,
        "deliveryMethodId": deliveryMethodId,
        "shippingAddress": shippingAddress.toMap(),
      };

  @override
  List<Object> get props => [basketId, deliveryMethodId, shippingAddress];
}

class ShippingAddress extends Equatable {
  final String street;
  final String city;

  const ShippingAddress({
    required this.street,
    required this.city,
  });

  factory ShippingAddress.fromMap(Map<String, dynamic> json) => ShippingAddress(
        street: json["street"],
        city: json["city"],
      );

  Map<String, dynamic> toMap() => {
        "street": street,
        "city": city,
      };

  @override
  List<Object> get props => [street, city];
}
