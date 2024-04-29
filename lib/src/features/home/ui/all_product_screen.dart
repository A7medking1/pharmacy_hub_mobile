import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/core/widget/RequestWidget.dart';
import 'package:pharmacy_hub/src/core/widget/custom_grid_view.dart';
import 'package:pharmacy_hub/src/features/home/logic/pagination_bloc/pagination_bloc.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/product_card.dart';
import 'package:shimmer/shimmer.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key, required this.params});

  final AllProductScreenParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaginationBloc(sl())..add(GetProductsEvent(params.categoryId)),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Hero(
            tag: params.tag,
            child: Text(
              params.productType.name,
              style: context.titleSmall,
            ),
          ),
        ),
        body: PaginationScreenContent(
          categoryId: params.categoryId,
          productType: params.productType,
        ),
      ),
    );
  }
}

class PaginationScreenContent extends StatelessWidget {
  const PaginationScreenContent(
      {super.key, required this.categoryId, required this.productType});

  final String categoryId;
  final ProductType productType;

  @override
  Widget build(BuildContext context) {
    final PaginationBloc bloc = context.read<PaginationBloc>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PaginationBloc, PaginationState>(
        builder: (context, state) {
          return RequestStateWidget(
            reqState: state.getMedicineReqState,
            onLoading: GridViewPagination(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: isProductMedicine ? 15 : 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.3,
              ),
              itemBuilder: (context, index) {
                return const SingleShimmerWidget();
              },
              addEvent: () {},
            ),
            onSuccess: GridViewPagination(
              itemCount: bloc.hasReachedMax
                  ? state.medicine.length
                  : state.medicine.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.3,
              ),
              itemBuilder: (context, index) {
                if (index >= state.medicine.length && bloc.page > 1) {
                  return const SingleShimmerWidget();
                }
                /* if (isProductMedicine) {
                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.productDetails,
                          extra: ProductDetailsParams(
                            productType: productType,
                            productModel: state.medicine[index],
                            uniqueKey: UniqueKey(),
                            similar: const [],
                          ));
                    },
                    child: MedicineItem(
                      model: state.medicine[index],
                    ),
                  );
                }*/
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
                bloc.add(
                  GetProductsEvent(categoryId),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<Object?> buildPushNamed(
      BuildContext context, PaginationState state, int index) {
    return context.pushNamed(Routes.productDetails,
        extra: ProductDetailsParams(
          productType: productType,
          productModel: state.medicine[index],
          uniqueKey: UniqueKey(),
          similar: state.medicine,
        ));
  }

  bool get isProductMedicine => productType == ProductType.medicine;
}

class SingleShimmerWidget extends StatelessWidget {
  const SingleShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      // Adjust the shimmer base color
      highlightColor: Colors.grey[300]!,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white, // Background color for the shimmer effect
        ),
      ),
    );
  }
}

class AllProductScreenParams extends Equatable {
  final ProductType productType;
  final Object tag;
  final String categoryId;

  const AllProductScreenParams({
    required this.categoryId,
    required this.productType,
    required this.tag,
  });

  @override
  List<Object> get props => [productType, tag, categoryId];
}
