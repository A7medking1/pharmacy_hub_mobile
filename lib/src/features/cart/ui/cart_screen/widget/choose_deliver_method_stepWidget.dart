import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/widget/RequestWidget.dart';
import 'package:pharmacy_hub/src/features/order/logic/order_bloc.dart';

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
                              duration: const Duration(milliseconds: 100),
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
                                          color: AppColors.grey,
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
