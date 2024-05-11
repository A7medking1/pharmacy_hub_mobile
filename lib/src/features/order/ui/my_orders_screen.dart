import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/services/index.dart';
import 'package:pharmacy_hub/src/core/widget/RequestWidget.dart';
import 'package:pharmacy_hub/src/features/order/data/models/my_order_model.dart';
import 'package:pharmacy_hub/src/features/order/logic/order_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OrderBloc>()..add(GetMyOrdersEvent()),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(
            'My Orders',
            style: context.titleSmall,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return RequestStateWidget(
                reqState: state.getMyOrdersReqState,
                onLoading: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                      height: 180.h,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[100]!,
                        // Adjust the shimmer base color
                        highlightColor: Colors.grey[300]!,
                        // Adjust the shimmer highlight color
                        child: Container(
                          width: 150.h,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors
                                .white, // Background color for the shimmer effect
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 10,
                ),
                onSuccess: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.myOrders.length,
                  separatorBuilder: (context, index) => 20.verticalSpace,
                  itemBuilder: (context, index) {
                    return OrderItems(
                      order: state.myOrders[index],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class OrderItems extends StatelessWidget {
  const OrderItems({
    super.key,
    required this.order,
  });

  final MyOrdersModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15.r),
        border: Border.all(color: AppColors.grey.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'order id:  ${order.id}',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 12.sp,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsetsDirectional.all(9),
                // width: 60,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  color: orderStatusColor(order.status),
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(15.r),
                    bottomStart: Radius.circular(15.r),
                  ),
                ),
                child: Text(
                  order.status,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 12.sp,
                        color: orderTextStatusColor(order.status),
                      ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'date: ${order.orderDate.toString().formatDateTime()}',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 12.sp,
                  ),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  order.items.length,
                  (index) => Row(
                    children: [
                      Text(
                        '${index + 1}-',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 13.sp),
                      ),
                      7.horizontalSpace,
                      Text(
                        order.items[index].productName,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'total price',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 15.sp),
                    ),
                    Text(
                      '\$${order.total}',
                      style: context.titleSmall!.copyWith(
                        color: AppColors.primary,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension DateTimeExtensions on String {
  String formatDateTime() {
    DateTime dateTime = DateTime.parse(this);
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }
}

Color orderStatusColor(String status) {
  switch (status) {
    case 'Pending':
    case 'Delivering':
    case 'Processing':
      return AppColors.grey.withOpacity(0.2);
    case 'PaymentRecieved':
      return AppColors.greenWIthOp;
    case 'Cancelled':
      return AppColors.redWIthOp;
  }
  return Colors.black;
}

Color orderTextStatusColor(String status) {
  switch (status) {
    case 'pending':
    case 'delivering':
    case 'processing':
      return AppColors.grey;
    case 'PaymentRecieved':
      return AppColors.primary;
    case 'cancelled':
      return AppColors.red;
  }
  return Colors.black;
}
