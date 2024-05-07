import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/payment_service/stripe/payment_intent_request_model.dart';

// 1- create payment intent (amount , currency ) ;
// 2- init payment sheet
// 3- present payment sheet

class StripServices {
  Future<void> initPaymentSheet(String secret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: secret,
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> createPaymentIntent(PaymentIntentRequestModel model) async {
    final response = await _getPaymentIntent(model.toJson());
    return response.data['client_secret'];
  }

  Future<void> displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makePayment(PaymentIntentRequestModel model) async {
    //final String paymentIntent = await createPaymentIntent(model);

    /// TODO - add your own payment intent

    const String paymentIntent = "pi_3PDs8PCUzw0yD3H30dIglov2_secret_yBugrw3EcMbm1ImYAfJjn17aP";

    await initPaymentSheet(paymentIntent);

    await displayPaymentSheet();
  }
}

Future<Response> _getPaymentIntent(Map<String, dynamic> body) async {
  Response response = await Dio().post(
    'https://api.stripe.com/v1/payment_intents',
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        'Authorization': 'Bearer ${ApiConstant.STRIPE_SECRET_KEY}',
      },
    ),
    data: body,
  );

  print(response);
  return response;
}
