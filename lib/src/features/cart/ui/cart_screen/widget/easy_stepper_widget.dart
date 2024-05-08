import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';

class CustomEasyStepper extends StatelessWidget {
  const CustomEasyStepper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return EasyStepper(
          activeStep: state.selectedStepper,
          enableStepTapping: false,
          stepShape: StepShape.circle,
          stepBorderRadius: 0,
          borderThickness: 2,
          stepRadius: 20.r,
          padding: const EdgeInsetsDirectional.only(
            end: 0,
            bottom: 0,
            start: 0,
            top: 0,
          ),
          finishedStepBackgroundColor: AppColors.primaryWithOp,
          finishedStepIconColor: AppColors.white,
          internalPadding: 20.w,
          fitWidth: true,
          disableScroll: false,
          showLoadingAnimation: true,
          activeStepIconColor: Colors.white,
          activeStepBackgroundColor: Colors.black45,
          unreachedStepIconColor: AppColors.black,
          steps: [
            buildEasyStep(
              title: 'Cart',
              context: context,
              icon: Icons.shopping_cart,
            ),
            buildEasyStep(
              title: 'delivery',
              context: context,
              icon: Icons.delivery_dining_sharp,
            ),
            buildEasyStep(
              title: 'Address',
              context: context,
              icon: Icons.location_on_outlined,
            ),
            buildEasyStep(
              title: 'payment',
              context: context,
              icon: Icons.payment,
            ),
          ],
        );
      },
    );
  }
}

EasyStep buildEasyStep(
    {required String title, required BuildContext context, IconData? icon}) {
  return EasyStep(
    icon: Icon(icon),
    finishIcon: Icon(
      Icons.done,
      color: AppColors.black,
    ),
    activeIcon: const Icon(
      Icons.access_alarm,
      color: AppColors.white,
    ),
    customTitle: Text(
      title,
      textAlign: TextAlign.center,
      style: context.titleSmall.copyWith(
        fontSize: 14.sp,
      ),
    ),
  );
}
