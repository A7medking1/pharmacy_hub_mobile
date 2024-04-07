import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/features/home/logic/search_bloc/search_bloc.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/product_card.dart';

import '../../../core/resources/app_assets.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/resources/size_manager.dart';
import '../../../core/widget/RequestWidget.dart';
import '../../../core/widget/custom_button.dart';
import '../../../core/widget/custom_grid_view.dart';
import 'all_product_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSize.pagePadding.h),
            child: Column(
              children: [
                // search bar
                Hero(
                  tag: 'home-search',
                  child: Container(
                    // padding:
                    // EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                    margin: EdgeInsets.symmetric(
                        horizontal: AppSize.pagePadding.w),
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.primary.withOpacity(.05),
                      border: Border.all(
                          color: AppColors.primary.withOpacity(.1)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomButton(
                          onTap: () => context.pop(),
                          width: 50.w,
                          height: 50.h,
                          borderRadius: 15,
                          padding: EdgeInsets.zero,
                          color: AppColors.transparent,
                          icon: Icon(
                            Platform.isIOS
                                ? Icons.arrow_back_ios_new_rounded
                                : Icons.arrow_back_rounded,
                            color: AppColors.palePrimary,
                            size: 20.sp,
                          ),
                        ),
                        5.horizontalSpace,
                        Expanded(
                          child: Material(
                            color: AppColors.transparent,
                            child: TextFormField(
                              controller:
                              context
                                  .read<SearchBloc>()
                                  .searchController,
                              textInputAction: TextInputAction.search,
                              keyboardType: TextInputType.text,
                              style: context.titleMedium.copyWith(
                                fontSize: 12.sp,
                                color: AppColors.black,
                                height: 2,
                                letterSpacing: .6,
                              ),
                              onFieldSubmitted: (text) {
                                context
                                    .read<SearchBloc>()
                                    .add(SearchForEvent(text));
                              },
                              cursorHeight: 25.h,
                              cursorColor: AppColors.black.withOpacity(.8),
                              decoration: InputDecoration.collapsed(
                                hintText: "Search for medicine & wellness products",
                                hintStyle: context.titleMedium.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.palePrimary.withOpacity(.5),
                                  height: 2,
                                  letterSpacing: .6,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // body
                AppSize.pagePadding.verticalSpace,
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    return context
                        .read<SearchBloc>()
                        .notFound
                        ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSize.pagePadding.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: context
                                        .read<SearchBloc>()
                                        .searchController
                                        .text,
                                    style: context.titleMedium.copyWith(
                                        color: AppColors.red,
                                        fontSize: 16.sp),
                                    children: [
                                      TextSpan(
                                        text:
                                        " not found",
                                        style: context.titleMedium.copyWith(
                                            color: AppColors.palePrimary
                                                .withOpacity(.7),
                                            fontSize: 16.sp),

                                      )
                                    ]),
                              ))
                        ],
                      ),
                    )
                        : RequestStateWidget(
                      reqState: state.getSearchReqState,
                      onLoading: Padding(
                        padding: EdgeInsets.all(AppSize.pagePadding.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30.h,
                              width: 30.h,
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeCap: StrokeCap.round,
                                strokeWidth: 2.w,
                              ),
                            )
                          ],
                        ),
                      ),
                      onNothing: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSize.pagePadding.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                                  "Search about all medicine you want and stay alive for another day with us",
                                  style: context.titleMedium.copyWith(
                                      color: AppColors.palePrimary,
                                      fontSize: 12.sp),
                                  textAlign: TextAlign.center,
                                ))
                          ],
                        ),
                      ),
                      onSuccess: Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppSize.pagePadding.w),
                          child: GridViewPagination(
                            itemCount:
                            context
                                .read<SearchBloc>()
                                .hasReachedMax
                                ? state.medicine.length
                                : state.medicine.length + 1,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1 / 1.3,
                            ),
                            itemBuilder: (context, index) {
                              if (index >= state.medicine.length &&
                                  !context
                                      .read<SearchBloc>()
                                      .hasReachedMax) {
                                return const SingleShimmerWidget();
                              }
                              return GestureDetector(
                                onTap: () {
                                  buildPushNamed(context, state, index);
                                },
                                child: ProductItemWidget(
                                  model: state.medicine[index],
                                ),
                              );
                            },
                            addEvent: () {
                              context
                                  .read<SearchBloc>()
                                  .add(SearchForEvent(null, true));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          )),
    );
  }

  Future<Object?> buildPushNamed(BuildContext context, SearchState state,
      int index) {
    return context.pushNamed(Routes.productDetails,
        extra: ProductDetailsParams(
          productType: state.medicine[index].categoryId == 1 ? ProductType
              .medicine : state.medicine[index].categoryId == 2 ? ProductType
              .vitamins : state.medicine[index].categoryId == 3 ? ProductType
              .equipment :  ProductType
              .cares,
          productModel: state.medicine[index],
          uniqueKey: UniqueKey(),
          similar: state.medicine,
        ));
  }
}
