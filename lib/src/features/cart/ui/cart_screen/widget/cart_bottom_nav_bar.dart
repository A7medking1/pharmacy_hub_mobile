import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/app_prefs/app_prefs.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/core/widget/RequestWidget.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';
import 'package:pharmacy_hub/src/features/order/data/models/address_model.dart';
import 'package:pharmacy_hub/src/features/order/logic/order_bloc.dart';

class CartBottomNavBar extends StatelessWidget {
  const CartBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return RequestStateWidget(
          reqState: state.getCartReqState,
          onError: const SizedBox.shrink(),
          onLoading: const SizedBox.shrink(),
          onSuccess: state.selectedStepper == 3
              ? const SizedBox.shrink()
              : Container(
                  color: AppColors.backGroundColor,
                  margin: EdgeInsetsDirectional.only(bottom: 15.h),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.selectedStepper == 0) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SubTotal',
                              style: context.titleSmall.copyWith(),
                            ),
                            Text(
                              'EGP ${state.totalPrice.toStringAsFixed(2)}',
                              style: context.titleSmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        /*  15.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery',
                              style: context.titleSmall.copyWith(),
                            ),
                            Text(
                              'EGP 00.00',
                              style: context.titleSmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),*/
                        10.verticalSpace,
                        const Divider(
                          thickness: 1.5,
                        ),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: context.titleMedium.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'EGP ${state.totalPrice.toStringAsFixed(2)}',
                              style: context.titleMedium.copyWith(
                                color: AppColors.primary,
                                fontSize: 23.sp,
                              ),
                            ),
                          ],
                        ),
                        15.verticalSpace,
                      ],
                      BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, orderState) {
                          return CustomButton(
                            onTap: () {
                              if (state.selectedStepper == 1) {
                                context
                                    .read<OrderBloc>()
                                    .add(const AddDeliveryMethodEvent());
                              }

                              if (state.selectedStepper == 2) {
                                context.read<OrderBloc>().add(
                                      UpdateAddressEvent(
                                        addressModel: state.addressModel ?? AddressModel(street: sl <AppPreferences>().getUser().street, city: sl <AppPreferences>().getUser().city),
                                      ),
                                    );
                              }

                              context
                                  .read<CartBloc>()
                                  .add(ChangeStepperEvent());
                            },
                            text: state.selectedStepper == 0
                                ? 'Proceed order'
                                : 'Continue',
                            //   text: 'Continue',
                          );
                        },
                      ),
                    ],
                  ),
                ),
          onEmpty: const SizedBox.shrink(),
        );
      },
    );
  }
}
