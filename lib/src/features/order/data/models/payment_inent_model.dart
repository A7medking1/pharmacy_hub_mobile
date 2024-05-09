import 'package:equatable/equatable.dart';

class PaymentIntentModel extends Equatable {
  final int deliveryMethodId;
  final int shippingPrice;
  final String paymentIntetId;
  final String clientSecret;

  const PaymentIntentModel({
    required this.deliveryMethodId,
    required this.shippingPrice,
    required this.paymentIntetId,
    required this.clientSecret,
  });

  factory PaymentIntentModel.fromMap(Map<String, dynamic> json) =>
      PaymentIntentModel(
        deliveryMethodId: json["deliveryMethodId"],
        shippingPrice: json["shippingPrice"],
        paymentIntetId: json["paymentIntetId"],
        clientSecret: json["clientSecret"],
      );

  Map<String, dynamic> toMap() => {
        "deliveryMethodId": deliveryMethodId,
        "shippingPrice": shippingPrice,
        "paymentIntetId": paymentIntetId,
        "clientSecret": clientSecret,
      };

  @override
  List<Object> get props => [
        deliveryMethodId,
        shippingPrice,
        paymentIntetId,
        clientSecret,
      ];
}
