import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/widget/cached_image_network.dart';
import 'package:pharmacy_hub/src/features/cart/logic/cart_bloc.dart';

class FirstStepCartWidget extends StatelessWidget {
  const FirstStepCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
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
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => Card(
                      color: AppColors.backGroundColor,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedImages(
                              imageUrl: state.cart.items[index].pictureUrl,
                              //width: 100,
                              height: 70.h,
                              fit: BoxFit.contain,
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.cart.items[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.titleSmall.copyWith(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  15.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<CartBloc>()
                                              .add(DecreaseItemQuantityEvent(
                                                state.cart.items[index],
                                              ));
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          size: 20,
                                        ),
                                      ),
                                      10.horizontalSpace,
                                      Text(
                                        '${state.cart.items[index].quantity}x',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.titleSmall.copyWith(
                                          fontSize: 16.sp,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      10.horizontalSpace,
                                      InkWell(
                                        onTap: () {
                                          context.read<CartBloc>().add(
                                              IncreaseItemQuantityEvent(
                                                  state.cart.items[index]));

                                          log((state.cart.items[index].id)
                                              .toString());
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            5.horizontalSpace,
                            Column(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Text(
                                    'EGP ${state.cart.items[index].price.toString()}',
                                    style: context.titleSmall.copyWith(
                                      fontSize: 13.sp,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                                15.verticalSpace,
                                InkWell(
                                  onTap: () {
                                    context.read<CartBloc>().add(
                                          RemoveCartItemLocalEvent(
                                              state.cart.items[index].id),
                                        );
                                  },
                                  child: const Icon(
                                    Icons.delete_outline,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => 5.verticalSpace,
                    itemCount: state.cart.items.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
