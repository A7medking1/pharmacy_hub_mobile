import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/core/widget/RequestWidget.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/cart_bottom_nav_bar.dart';
import 'package:pharmacy_hub/src/features/cart/ui/cart_screen/widget/cart_shimmer_loading.dart';
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
    //   BlocProvider.of<CartBloc>(context).add(const GetCartDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CartBloc>()..add(const GetCartDataEvent()),
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
                            //    const BackButton(),
                            const CustomEasyStepper(),
                            if (state.selectedStepper == 0)
                              const FirstStepCartWidget(),
                            if (state.selectedStepper == 1)
                              const SecondStepAddressWidget(),
                            if (state.selectedStepper == 2)
                              const ThirdStepPaymentWidget(),
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
}

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*   const Align(
            alignment: AlignmentDirectional.topStart,
            child: BackButton(),
          ),*/
          200.verticalSpace,
          SvgPicture.asset(
            AppSvg.cart,
            height: 100.h,
          ),
          15.verticalSpace,
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Your cart is empty. Let\'s add some products!',
              style: context.titleSmall,
            ),
          ),
        ],
      ),
    );
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
