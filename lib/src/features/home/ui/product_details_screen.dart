import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/hepler.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/widget/RequestWidget.dart';
import 'package:pharmacy_hub/src/core/widget/cached_image_network.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/core/widget/list_view_horizontal.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';
import 'package:pharmacy_hub/src/features/home/data/repository/repository.dart';
import 'package:pharmacy_hub/src/features/home/logic/home_bloc.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/medicine_card.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.params});

  final ProductDetailsParams params;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(GetMedicineSimilarEvent(SimilarProductParams(
        page: '1',
        diseaseId: widget.params.productModel.diseaseId.toString(),
        categoryId: widget.params.productModel.categoryId.toString())));
    context.read<HomeBloc>().add(GetMedicineAlternativeEvent(
        AlternativeProductParams(
            page: '1',
            activeIngredientId:
                widget.params.productModel.activeIngredientId.toString(),
            categoryId: widget.params.productModel.categoryId.toString())));
  }

  @override
  Widget build(BuildContext context) {
    print('_key ${widget.params.uniqueKey}');

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  forceMaterialTransparency: true,
                  pinned: true,
                  expandedHeight: 250.0.h,
                  stretch: true,
                  actions: [
                    SvgPicture.asset(
                      AppSvg.share,
                      height: 22,
                      fit: BoxFit.scaleDown,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 15),
                      child: SvgPicture.asset(
                        AppSvg.fav,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.5, 1.0, 0.5],
                          ).createShader(
                            Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: Hero(
                          tag: widget.params.uniqueKey.toString(),
                          child: CachedImages(
                            imageUrl: widget.params.productModel.pictureUrl,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsetsDirectional.only(
                      start: 15.w, end: 15.w, top: 15.h),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.params.productModel.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.titleSmall,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsetsDirectional.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Text(
                            'in stock',
                            style: context.titleSmall.copyWith(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsetsDirectional.only(
                      start: 15.w, end: 15.w, top: 15.h),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Text(
                          'price: ',
                          style: context.titleSmall.copyWith(
                            color: AppColors.grey,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          'EGP ${widget.params.productModel.price}',
                          style: context.titleSmall.copyWith(
                            color: AppColors.primary,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsetsDirectional.only(
                      start: 15.w, end: 15.w, top: 15.h),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available in',
                          style: context.titleSmall.copyWith(
                            fontSize: 13.sp,
                          ),
                        ),
                        10.verticalSpace,
                        Wrap(
                          children: widget.params.productModel.pharmacies
                              .map((e) => Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 8.w),
                                    margin: EdgeInsets.only(
                                        right: 10.w, bottom: 8.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: AppColors.primary.withOpacity(.03),
                                      border: Border.all(
                                          color: AppColors.primary
                                              .withOpacity(.1)),
                                    ),
                                    child: Text(
                                      e,
                                      style: context.titleSmall.copyWith(
                                          fontSize: 13.sp,
                                          color:
                                              AppColors.black.withOpacity(.8)),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.getAlternativeMedicineReqState !=
                      current.getAlternativeMedicineReqState,
                  builder: (context, state) {
                    return RequestStateWidgetWithSlivers(
                      reqState: state.getAlternativeMedicineReqState,
                      onLoading: const SliverToBoxAdapter(
                          child: MedicineCardShimmer()),
                      onSuccess: SliverPadding(
                        padding: EdgeInsetsDirectional.only(
                            start: 15.w, end: 15.w, top: 15.h),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Medicine Alternative',
                                style: context.titleSmall.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                              20.verticalSpace,
                              ListViewHorizontal(
                                count: state.alternativeMedicine.length,
                                height: 160.h,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                itemBuilder: (context, index) {
                                  UniqueKey _key = UniqueKey();

                                  return GestureDetector(
                                    onTap: () {
                                      context.pushNamed(Routes.productDetails,
                                          extra: ProductDetailsParams(
                                              productModel: state
                                                  .alternativeMedicine[index],
                                              uniqueKey: _key));
                                    },
                                    child: MedicineSimilarItem(
                                      model: state.alternativeMedicine[index],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.getSimilarMedicineReqState !=
                      current.getSimilarMedicineReqState,
                  builder: (context, state) {
                    return RequestStateWidgetWithSlivers(
                      reqState: state.getSimilarMedicineReqState,
                      onLoading: const SliverToBoxAdapter(
                          child: MedicineCardShimmer()),
                      onSuccess: SliverPadding(
                        padding: EdgeInsetsDirectional.only(
                            start: 15.w, end: 15.w, top: 15.h),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Medicine Similar',
                                style: context.titleSmall.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                              20.verticalSpace,
                              ListViewHorizontal(
                                count: state.similarMedicine.length,
                                height: 160.h,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                itemBuilder: (context, index) {
                                  UniqueKey _key = UniqueKey();
                                  return Hero(
                                    tag: _key.toString(),
                                    child: GestureDetector(
                                      onTap: () {
                                        print('_key $_key');
                                        context.pushNamed(Routes.productDetails,
                                            extra: ProductDetailsParams(
                                                productModel: state
                                                    .similarMedicine[index],
                                                uniqueKey: _key));
                                      },
                                      child: MedicineSimilarItem(
                                        model: state.similarMedicine[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                /// just height from bottom
                SliverToBoxAdapter(child: 100.verticalSpace),
              ],
            ),
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 30, horizontal: 100),
              child: CustomButton(
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppSvg.cart,
                      color: Colors.white,
                    ),
                    10.horizontalSpace,
                    Text(
                      'Add to cart',
                      style: context.titleSmall.copyWith(color: Colors.white),
                    )
                  ],
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicineSimilarItem extends StatelessWidget {
  const MedicineSimilarItem({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 250.h,
      width: 180.w,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.primary.withOpacity(.03),
        border: Border.all(color: AppColors.primary.withOpacity(.1)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: CachedImages(
                    imageUrl: model.pictureUrl,
                    width: 80.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                ),
                10.verticalSpace,
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleSmall.copyWith(
                        height: 1.15, fontSize: 14.sp, color: AppColors.black),
                  ),
                ),
                5.verticalSpace,
                Text(
                  'EGP ${model.price}',
                  style: context.titleSmall.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeightManager.regular),
                ),
                5.verticalSpace,
              ],
            ),
          ),
          PositionedDirectional(
            top: 2,
            end: 3,
            child: Column(
              children: [
                CustomButton(
                  onTap: () {},
                  width: 40.h,
                  height: 40.h,
                  borderRadius: 999,
                  padding: EdgeInsets.zero,
                  color: AppColors.transparent,
                  icon: Icon(
                    Icons.favorite_outline_rounded,
                    color: AppColors.primary,
                    size: 20.h,
                  ),
                ),
                CustomButton(
                  onTap: () {},
                  width: 40.h,
                  height: 40.h,
                  borderRadius: 999,
                  padding: EdgeInsets.zero,
                  color: AppColors.transparent,
                  icon: Icon(
                    Icons.add_shopping_cart_rounded,
                    color: AppColors.primary,
                    size: 20.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
