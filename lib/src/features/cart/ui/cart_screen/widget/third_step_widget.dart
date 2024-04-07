import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/payment_service/paypal/paypal_checkout_view.dart';
import 'package:pharmacy_hub/src/core/payment_service/stripe/payment_intent_request_model.dart';
import 'package:pharmacy_hub/src/core/payment_service/stripe/stripe_services.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';

class ThirdStepPaymentWidget extends StatelessWidget {
  const ThirdStepPaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 13.w, top: 8.h, end: 8.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppSvg.money,
              ),
              30.verticalSpace,
              /* Container(
                padding: EdgeInsetsDirectional.all(8.h) ,
                decoration: BoxDecoration(
                color: AppCOl,
                  borderRadius: BorderRadiusDirectional.circular(
                    10.r,
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppSvg.paypal,
                      height: 35.h,
                      width: 35.w,
                    ),
                  ],
                ),
              )*/
              CustomButton(
                color: AppColors.backGroundColor,
                isBorderButton: true,
                widget: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppSvg.paypal,
                      height: 35.h,
                      width: 35.w,
                    ),
                    15.horizontalSpace,
                    Text(
                      'Continue with Paypal',
                      style: context.titleSmall.copyWith(),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PaypalCheckoutView(
                      clientId: ApiConstant.PAYPAL_CLIENT_ID,
                      secretKey: ApiConstant.PAYPAL_SECRET_KEY,
                      transactions: const [
                        {
                          "amount": {
                            "total": '100',
                            "currency": "USD",
                            "details": {
                              "subtotal": '100',
                              "shipping": '0',
                              "shipping_discount": 0
                            }
                          },
                          "description": "The payment transaction description.",
// "payment_options": {
//   "allowed_payment_method":
//       "INSTANT_FUNDING_SOURCE"
// },
                          "item_list": {
                            "items": [
                              {
                                "name": "Apple",
                                "quantity": 4,
                                "price": '10',
                                "currency": "USD"
                              },
                              {
                                "name": "Pineapple",
                                "quantity": 5,
                                "price": '12',
                                "currency": "USD"
                              }
                            ],
                          }
                        }
                      ],
                      note: "Contact us for any questions on your order.",
                      onSuccess: (Map params) async {
                        log("onSuccess: $params");
                        Navigator.pop(context);
                      },
                      onError: (error) {
                        log("onError: $error");
                        Navigator.pop(context);
                      },
                      onCancel: () {
                        print('cancelled:');
                        Navigator.pop(context);
                      },
                    ),
                  ));
                },
              ),
              40.verticalSpace,
              CustomButton(
                color: AppColors.backGroundColor,
                isBorderButton: true,
                widget: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppSvg.stripe,
                      height: 35.h,
                      width: 35.w,
                    ),
                    15.horizontalSpace,
                    Text(
                      'Continue with Stripe',
                      style: context.titleSmall.copyWith(),
                    ),
                  ],
                ),
                onTap: () {
                  //   context.pushNamed(Routes.successPayment);

                  StripServices().makePayment(
                    const PaymentIntentRequestModel(
                      amount: '1000',
                      currency: 'USD',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
