import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/core/widget/RequestWidget.dart';
import 'package:pharmacy_hub/src/core/widget/cached_image_network.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/core/widget/list_view_horizontal.dart';
import 'package:pharmacy_hub/src/features/home/data/repository/repository.dart';
import 'package:pharmacy_hub/src/features/home/logic/home_bloc.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/favorite_icon_widget.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/product_card.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/shimmer_widget.dart';

import 'all_product_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.params});

  final ProductDetailsParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(sl()),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: ProductDetailsBody(
            params: params,
          ),
        ),
      ),
    );
  }
}

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({super.key, required this.params});

  final ProductDetailsParams params;

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.params.productType == ProductType.medicine) {
      context.read<HomeBloc>().add(GetMedicineSimilarEvent(SimilarProductParams(
          productId: widget.params.productModel.id.toString(),
          page: '1',
          diseaseId: widget.params.productModel.diseaseId.toString(),
          categoryId: widget.params.productModel.categoryId.toString())));
      context.read<HomeBloc>().add(GetMedicineAlternativeEvent(
          AlternativeProductParams(
              productId: widget.params.productModel.id.toString(),
              page: '1',
              activeIngredientId:
                  widget.params.productModel.activeIngredientId.toString(),
              categoryId: widget.params.productModel.categoryId.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.params.uniqueKey);
    return Stack(
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
/*
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 15),
                  child: SvgPicture.asset(
                    AppSvg.fav,
                    fit: BoxFit.scaleDown,
                  ),
                ),
*/
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 15),
                  child: FavoriteIconWidget(
                    model: widget.params.productModel,
                    size: 30.h,
                    unFavoriteColor: Colors.black,
                    index: widget.params.itemIndex,
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
              padding:
                  EdgeInsetsDirectional.only(start: 15.w, end: 15.w, top: 15.h),
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
                        color: stockColor,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Text(
                        stockTitle,
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
              padding:
                  EdgeInsetsDirectional.only(start: 15.w, end: 15.w, top: 15.h),
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

            if (isProductInStock)
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
                                  margin:
                                      EdgeInsets.only(right: 10.w, bottom: 8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: AppColors.primary.withOpacity(.03),
                                    border: Border.all(
                                        color:
                                            AppColors.primary.withOpacity(.1)),
                                  ),
                                  child: Text(
                                    e,
                                    style: context.titleSmall.copyWith(
                                        fontSize: 13.sp,
                                        color: AppColors.black.withOpacity(.8)),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),

            if (widget.params.productType == ProductType.medicine) ...[
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) =>
                    previous.getAlternativeMedicineReqState !=
                    current.getAlternativeMedicineReqState,
                builder: (context, state) {
                  return RequestStateWidgetWithSlivers(
                    reqState: state.getAlternativeMedicineReqState,
                    onLoading:
                        const SliverToBoxAdapter(child: MedicineCardShimmer()),
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
                              height: 220.h,
                              tag: 7,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              onTapViewAll: () {
                                context.pushNamed(
                                  Routes.allProduct,
                                  extra: AllProductScreenParams(
                                    productType: widget.params.productType,
                                    tag: 'Popular Cares',
                                    categoryId: widget
                                        .params.productModel.categoryId
                                        .toString(),
                                  ),
                                );
                              },
                              itemBuilder: (context, index) {
                                UniqueKey _key = UniqueKey();

                                return GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.productDetails,
                                      extra: ProductDetailsParams(
                                        productModel:
                                            state.alternativeMedicine[index],
                                        uniqueKey: _key,
                                        productType: widget.params.productType,
                                        similar: const [],
                                      ),
                                    );
                                  },
                                  child: ProductItemWidget(
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
                    onLoading:
                        const SliverToBoxAdapter(child: MedicineCardShimmer()),
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
                              tag: 6,
                              height: 220.h,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              onTapViewAll: () {
                                context.pushNamed(
                                  Routes.allProduct,
                                  extra: AllProductScreenParams(
                                    productType: widget.params.productType,
                                    tag: 'Popular Cares',
                                    categoryId: widget
                                        .params.productModel.categoryId
                                        .toString(),
                                  ),
                                );
                              },
                              itemBuilder: (context, index) {
                                UniqueKey _key = UniqueKey();

                                return Hero(
                                  tag: _key.toString(),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                        Routes.productDetails,
                                        extra: ProductDetailsParams(
                                          productModel:
                                              state.similarMedicine[index],
                                          uniqueKey: _key,
                                          productType:
                                              widget.params.productType,
                                          similar: const [],
                                        ),
                                      );
                                    },
                                    child: ProductItemWidget(
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
            ] else ...[
              SliverPadding(
                padding: EdgeInsetsDirectional.only(
                    start: 15.w, end: 15.w, top: 15.h),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.params.productType.name} Similar'
                            .capitalizedFirst(),
                        style: context.titleSmall.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                      20.verticalSpace,
                      ListViewHorizontal(
                        count: widget.params.similar.length,
                        tag: 6,
                        height: 200.h,
                        onTapViewAll: () {
                          context.pushNamed(
                            Routes.allProduct,
                            extra: AllProductScreenParams(
                              productType: widget.params.productType,
                              tag: 'Popular Cares',
                              categoryId: widget.params.productModel.categoryId
                                  .toString(),
                            ),
                          );
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        itemBuilder: (context, index) {
                          UniqueKey _key = UniqueKey();

                          return Hero(
                            tag: _key.toString(),
                            child: GestureDetector(
                              onTap: () {
                                print('_key.toString() ${_key.toString()}');

                                context.pushNamed(
                                  Routes.productDetails,
                                  extra: ProductDetailsParams(
                                    productModel: widget.params.similar[index],
                                    uniqueKey: _key,
                                    productType: widget.params.productType,
                                    similar: widget.params.similar,
                                  ),
                                );
                              },
                              child: ProductItemWidget(
                                model: widget.params.similar[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],

            /// just height from bottom
            SliverToBoxAdapter(child: 100.verticalSpace),
          ],
        ),
        if (isProductInStock)
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
    );
  }

  bool get isProductInStock =>
      widget.params.productModel.pharmacies.isNotEmpty &&
              widget.params.productModel.quantity > 0
          ? true
          : false;

  Color get stockColor => isProductInStock ? AppColors.primary : AppColors.red;

  String get stockTitle => isProductInStock ? 'in stock' : 'out of stock';
}
