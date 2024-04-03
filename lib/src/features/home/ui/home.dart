import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';
import 'package:pharmacy_hub/src/core/widget/RequestWidget.dart';
import 'package:pharmacy_hub/src/features/home/logic/home_bloc.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/cares_card.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/category_card.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/equipments_card.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/medicine_card.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/vitamins_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: AppSize.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.primary.withOpacity(.05),
                    border:
                        Border.all(color: AppColors.primary.withOpacity(.1)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppSvg.search,
                        width: 25.w,
                        color: AppColors.palePrimary,
                      ),
                      5.horizontalSpace,
                      Text("Search for medicine & wellness products",
                          style: context.titleMedium.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.palePrimary,
                              height: .7,
                              letterSpacing: .6))
                    ],
                  ),
                ),
                18.verticalSpace,
                Image.asset(
                  AppImages.slide,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          20.verticalSpace,
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (current, prev) =>
                current.getCategoriesReqState != prev.getCategoriesReqState,
            builder: (context, state) {
              return RequestStateWidget(
                reqState: state.getCategoriesReqState,
                onLoading: const CategoryShimmer(),
                onSuccess: CategoryCard(
                  categories: state.categories,
                ),
              );
            },
          ),
          15.verticalSpace,
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (current, prev) =>
                current.getMedicineReqState != prev.getMedicineReqState,
            builder: (context, state) {
              return RequestStateWidget(
                reqState: state.getMedicineReqState,
                onLoading: const MedicineCardShimmer(),
                onSuccess: MedicineCard(
                  product: state.medicine,
                ),
              );
            },
          ),
          15.verticalSpace,
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (current, prev) =>
                current.getVitaminsReqState != prev.getVitaminsReqState,
            builder: (context, state) {
              return RequestStateWidget(
                reqState: state.getVitaminsReqState,
                onLoading: const MedicineCardShimmer(),
                onSuccess: VitaminsCard(
                  product: state.vitamins,
                ),
              );
            },
          ),
          15.verticalSpace,
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (current, prev) =>
                current.getEquipmentsReqState != prev.getEquipmentsReqState,
            builder: (context, state) {
              return RequestStateWidget(
                reqState: state.getEquipmentsReqState,
                onLoading: const MedicineCardShimmer(),
                onSuccess: EquipmentsCard(
                  product: state.equipments,
                ),
              );
            },
          ),
          15.verticalSpace,
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (current, prev) =>
                current.getCaresReqState != prev.getCaresReqState,
            builder: (context, state) {
              return RequestStateWidget(
                reqState: state.getCaresReqState,
                onLoading: const MedicineCardShimmer(),
                onSuccess: CaresCard(
                  product: state.cares,
                ),
              );
            },
          ),
          (AppSize.buttomNavigationHeight + (20.h * 1)).verticalSpace
        ],
      ),
    );
  }

// @override
// bool get wantKeepAlive => true;
}

// Popular medicine
// Popular vitamins
// Popular equipment
// Popular equipment
