import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/features/favorites/logic/favorite_bloc.dart';
import 'package:pharmacy_hub/src/features/home/logic/home_bloc.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/product_card.dart';
import 'package:shimmer/shimmer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeState homeBloc = context.read<HomeBloc>().state;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Favorites',
          style: context.titleSmall,
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state.favoritesItems.isEmpty) {
           // return const CartShimmerWidget();

              return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppSvg.heart,
                    height: 120.h,
                  ),
                  15.verticalSpace,
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      ' \t No favorites yet. \n \t\t\t\t\t Browse products to find \n your favorites and add them to your list!!',
                      textAlign: TextAlign.center,
                      style: context.titleSmall,
                    ),
                  ),
                ],
              ),
            );
          }
          return FadeAnimation(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedGrid(
                key: context.read<FavoriteBloc>().gridKey,
                initialItemCount: state.favoritesItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index, animation) {
                  return ScaleTransition(
                    scale: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                    child: GestureDetector(
                      onTap: () => onTapItem(context, state, index, homeBloc),
                      child: ProductItemWidget(
                        model: state.favoritesItems[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void onTapItem(BuildContext context, FavoriteState state, int index,
      HomeState homeBloc) {
    context.pushNamed(
      Routes.productDetails,
      extra: ProductDetailsParams(
        itemIndex: index,
        productType: ProductTypeExtension.fromIndex(
          state.favoritesItems[index].categoryId - 1,
        ),
        productModel: state.favoritesItems[index],
        uniqueKey: UniqueKey(),
        similar: getCurrentList(
          ProductTypeExtension.fromIndex(
            state.favoritesItems[index].categoryId - 1,
          ),
          homeBloc.vitamins,
          homeBloc.equipments,
          homeBloc.cares,
        ),
      ),
    );
  }
}

