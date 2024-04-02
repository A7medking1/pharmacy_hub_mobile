import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';

class CartBottomNavBar extends StatelessWidget {
  const CartBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return state.selectedStepper == 2
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
                            'EGP 850.00',
                            style: context.titleSmall.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      15.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery',
                            style: context.titleSmall.copyWith(),
                          ),
                          Text(
                            'EGP 20.00',
                            style: context.titleSmall.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
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
                            'EGP 850.00',
                            style: context.titleMedium.copyWith(
                              color: AppColors.primary,
                              fontSize: 23.sp,
                            ),
                          ),
                        ],
                      ),
                      15.verticalSpace,
                    ],
                    CustomButton(
                      onTap: () {
                        context.read<CartBloc>().add(ChangeStepperEvent());
                      },
                      text: state.selectedStepper == 0
                          ? 'Proceed order'
                          : 'Continue',
                      //   text: 'Continue',
                    ),
                  ],
                ),
              );
      },
    );
  }
}
