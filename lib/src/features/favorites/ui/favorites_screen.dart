import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/features/favorites/logic/favorite_bloc.dart';
import 'package:pharmacy_hub/src/features/home/logic/home_bloc.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/product_card.dart';

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
          'Favorites Product',
          style: context.titleSmall,
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state.favoritesItems.isEmpty) {
            return Center(
              child: Text(
                'Empty',
                style: context.titleMedium,
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
