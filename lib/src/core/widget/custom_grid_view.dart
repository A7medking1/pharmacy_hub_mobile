import 'package:flutter/material.dart';
import 'package:pharmacy_hub/src/core/helper.dart';

class GridViewPagination extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final void Function() addEvent;
  final SliverGridDelegate? gridDelegate;

  const GridViewPagination({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.addEvent,
    this.gridDelegate,
  });

  @override
  State<GridViewPagination> createState() => _GridViewPaginationState();
}

class _GridViewPaginationState extends State<GridViewPagination> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.itemCount,
          gridDelegate: widget.gridDelegate ??
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                childAspectRatio: 1 / 1.3,
              ),
          itemBuilder: widget.itemBuilder,
        ),
      ),
    );
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (maxScroll == currentScroll) {
      widget.addEvent();
    }
  }
}
