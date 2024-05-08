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
import 'package:pharmacy_hub/src/features/order/logic/order_bloc.dart';

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
                            //    const BackButton(),
                            const CustomEasyStepper(),
                            if (state.selectedStepper == 0)
                              const FirstStepCartWidget(),
                            if (state.selectedStepper == 1)
                              const ChooseDeliverMethodStepWidget(),
                            if (state.selectedStepper == 2)
                              const SecondStepAddressWidget(),
                            if (state.selectedStepper == 3)
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

class ChooseDeliverMethodStepWidget extends StatelessWidget {
  const ChooseDeliverMethodStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, orderState) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.all(20),
            child: Column(
              children: [
                Text(
                  'Please select a shipping option that best suits your needs. We offer a range of choices varying in speed and cost.',
                  style: context.titleSmall.copyWith(
                    fontSize: 15.sp,
                  ),
                ),
                25.h.verticalSpace,
                RequestStateWidget(
                  reqState: orderState.getDeliveryReqState,
                  onLoading: const CircularProgressIndicator(),
                  onSuccess: Expanded(
                    child: GridView.builder(
                      itemCount: orderState.deliveryMethods.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1 / 1.1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<OrderBloc>()
                                .add(ChangeDeliveryMethodEvent(index: index));
                          },
                          child: Opacity(
                            opacity: orderState.selectedDeliveryMethod == index
                                ? 1
                                : 0.8,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                color: AppColors.backGroundColor,
                                borderRadius:
                                    BorderRadiusDirectional.circular(15.r),
                                border:
                                    orderState.selectedDeliveryMethod == index
                                        ? Border.all(
                                            color: AppColors.primary,
                                            width: 3.w,
                                          )
                                        : null,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        child: Text(
                                          orderState
                                              .deliveryMethods[index].name,
                                          style: context.titleSmall,
                                        ),
                                      ),
                                      15.verticalSpace,
                                      Text(
                                        orderState
                                            .deliveryMethods[index].description,
                                        style: context.titleSmall.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                      10.verticalSpace,
                                      Text(
                                          'Delivery Time: ${orderState.deliveryMethods[index].deliveryTime}',
                                          style: context.titleSmall.copyWith(
                                            color: AppColors.grey,
                                            fontSize: 13.sp,
                                          )),
                                    ],
                                  ),
                                  const Spacer(),
                                  //10.verticalSpace,
                                  Text(
                                    'EGP ${orderState.deliveryMethods[index].cost}',
                                    style: context.titleSmall.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
