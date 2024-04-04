import 'package:flutter/material.dart';
import 'package:pharmacy_hub/src/core/enums.dart';

class RequestStateWidget extends StatelessWidget {
  const RequestStateWidget({
    super.key,
    required this.reqState,
    required this.onLoading,
    required this.onSuccess,
  });

  final ReqState reqState;

  final Widget onSuccess;
  final Widget onLoading;

  @override
  Widget build(BuildContext context) {
    switch (reqState) {
      case ReqState.loading:
        return onLoading;
      case ReqState.empty:
        return const Center(child: Text("No data found"));
      case ReqState.error:
        return const Center(child: Text("An error occurred"));
      case ReqState.success:
        return onSuccess;
    }
  }
}



class RequestStateWidgetWithSlivers extends StatelessWidget {
  const RequestStateWidgetWithSlivers({
    super.key,
    required this.reqState,
    required this.onLoading,
    required this.onSuccess,
  });

  final ReqState reqState;

  final Widget onSuccess;
  final Widget onLoading;

  @override
  Widget build(BuildContext context) {
    switch (reqState) {
      case ReqState.loading:
        return onLoading;
      case ReqState.empty:
        return const SliverToBoxAdapter(child: Center(child: Text("No data found")));
      case ReqState.error:
        return const SliverToBoxAdapter(child: Center(child: Text("An error occurred")));
      case ReqState.success:
        return onSuccess;
    }
  }
}
