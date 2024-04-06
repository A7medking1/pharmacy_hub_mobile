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
          internalPadding: 50.w,
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
            ),
            buildEasyStep(
              title: 'Address',
              context: context,
            ),
            buildEasyStep(
              title: 'payment',
              context: context,
            ),
          ],
          //  onStepReached: (index) => setState(() => activeStep = index),
        );
      },
    );
  }
}

EasyStep buildEasyStep({required String title, required BuildContext context}) {
  return EasyStep(
    icon: const Icon(Icons.delivery_dining),
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
