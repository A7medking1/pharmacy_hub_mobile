import 'package:equatable/equatable.dart';

class PaymentIntentRequestModel extends Equatable {
  final String amount;

  final String currency;

  const PaymentIntentRequestModel({
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "currency": currency,
    };
  }

  @override
  List<Object> get props => [amount, currency];
}
