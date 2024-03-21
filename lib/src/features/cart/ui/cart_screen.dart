import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'cart',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                  ),
                ),
                const CustomEasyStepper(),
                if (state.selectedStepper == 0)
                  const Expanded(child: FirstStepCartWidget()),
                if (state.selectedStepper == 1) const SecondStepAddressWidget(),
                if (state.selectedStepper == 2) const ThirdStepPaymentWidget(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const CartBottomNavBar(),
    );
  }
}

class ThirdStepPaymentWidget extends StatelessWidget {
  const ThirdStepPaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('2222');
  }
}

class SecondStepAddressWidget extends StatelessWidget {
  const SecondStepAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text('11111');
  }
}

class FirstStepCartWidget extends StatelessWidget {
  const FirstStepCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 13.w, top: 8.h, end: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Order',
            style: context.titleSmall.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          5.verticalSpace,
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => Card(
                color: const Color(0xFFFAFAFA),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppImages.cart1,
                        fit: BoxFit.cover,
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cataflam 50mg',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleSmall.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            10.verticalSpace,
                            Text(
                              'x5',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleSmall.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      5.horizontalSpace,
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Text(
                          'EGP 350',
                          style: context.titleSmall.copyWith(
                            fontSize: 13.sp,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => 5.verticalSpace,
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}

class CartBottomNavBar extends StatelessWidget {
  const CartBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
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
                text: state.selectedStepper == 0 ? 'Proceed order' : 'Continue',
                //   text: 'Continue',
              ),
            ],
          ),
        );
      },
    );
  }
}

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
