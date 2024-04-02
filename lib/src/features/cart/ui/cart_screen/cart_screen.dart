import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/location_services.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/cart_bottom_nav_bar.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/easy_stepper_widget.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/first_step_widget.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/second_step_widget.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/third_step_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ss();
  }

  void ss() async {
    if (kDebugMode) {
      print(await LocationServices.getAddressFromCurrentLatLong());
    }
  }

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
                ),
                const CustomEasyStepper(),
                if (state.selectedStepper == 0) const FirstStepCartWidget(),
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
