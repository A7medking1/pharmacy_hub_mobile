import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/core/widget/RequestWidget.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/cart_bottom_nav_bar.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/cart_shimmer_loading.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/choose_deliver_method_stepWidget.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/easy_stepper_widget.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/empty_cart_widget.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/first_step_widget.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/address_widget.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/payment_widget.dart';
import 'package:pharmacy_hub/src/features/order/logic/order_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CartBloc>()..add(const GetCartDataEvent()),
        ),
        BlocProvider(
          create: (context) => sl<OrderBloc>()..add(GetDeliveryMethodsEvent()),
        ),
      ],
      child: Scaffold(
        body: PopScope(
          canPop: true,
          onPopInvoked: (bool value) {},
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackButton(),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return RequestStateWidget(
                      reqState: state.getCartReqState,
                      onLoading: const CartShimmerWidget(),
                      onEmpty: const EmptyCartWidget(),
                      onSuccess: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomEasyStepper(),
                            _getStepWidget(state.selectedStepper),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CartBottomNavBar(),
      ),
    );
  }

  Widget _getStepWidget(int selectedStepper) {
    switch (selectedStepper) {
      case 0:
        return const FirstStepCartWidget();
      case 1:
        return const ChooseDeliverMethodStepWidget();
      case 2:
        return const StepAddressWidget();
      case 3:
        return const StepPaymentWidget();
      default:
        return const SizedBox(); // Return an empty widget or handle the default case appropriately
    }
  }
}


class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'cart',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        // Use CustomButton widget you was created, i added some features to it.
        child: CustomButton(
          onTap: () => context.pop(),
          width: 60.h,
          height: 60.h,
          borderRadius: 999,
          color: AppColors.transparent,
          padding: EdgeInsets.zero,
          icon: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            color: AppColors.black,
            size: 23.w,
          ),
        ),
      ),
    );
  }
}
