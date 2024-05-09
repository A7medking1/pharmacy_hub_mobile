import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';
import 'package:pharmacy_hub/src/features/order/logic/order_bloc.dart';

class ThirdStepPaymentWidget extends StatelessWidget {
  const ThirdStepPaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
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
                70.verticalSpace,
                BlocConsumer<OrderBloc, OrderState>(
                  listener: (context, state) {
                    switch (state.getPaymentIntentReqState) {
                      case ReqState.success:
                        context.read<CartBloc>().add(ClearAllCartLocalEvent());
                        context.read<CartBloc>().add(ClearCartItemsEvent());
                        context.goNamed(Routes.successPayment);
                        break;
                      case ReqState.error:
                        break;
                      default:
                        break;
                    }
                  },
                  builder: (context, state) {
                    return state.getPaymentIntentReqState == ReqState.loading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
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
                              context
                                  .read<OrderBloc>()
                                  .add(GetPaymentIntentEvent());
                              //   context.pushNamed(Routes.successPayment);
                              //  StripServices().makePayment('');
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
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
),*/
