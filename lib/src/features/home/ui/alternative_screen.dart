import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/routes_manager.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/core/widget/RequestWidget.dart';
import 'package:pharmacy_hub/src/core/widget/custom_grid_view.dart';
import 'package:pharmacy_hub/src/features/home/data/models/request_params.dart';
import 'package:pharmacy_hub/src/features/home/logic/home_bloc.dart';
import 'package:pharmacy_hub/src/features/home/ui/all_product_screen.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/product_card.dart';

class AlternativeScreen extends StatelessWidget {
  const AlternativeScreen({
    super.key,
    required this.params,
  });

  final AlternativeProductParams params;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(sl())..add(GetMedicineAlternativeEvent(params)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'alternative products',
            style: context.titleSmall,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return RequestStateWidget(
                reqState: state.getAlternativeMedicineReqState,
                onLoading: GridViewPagination(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemBuilder: (context, index) {
                    return const SingleShimmerWidget();
                  },
                  addEvent: () {},
                ),
                onSuccess: GridViewPagination(
                  itemCount: state.alternativeMedicine.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          Routes.productDetails,
                          extra: ProductDetailsParams(
                            productType: ProductType.medicine,
                            productModel: state.alternativeMedicine[index],
                            uniqueKey: UniqueKey(),
                            similar: state.medicine,
                          ),
                        );
                      },
                      child: ProductItemWidget(
                        model: state.alternativeMedicine[index],
                      ),
                    );
                  },
                  addEvent: () {},
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
