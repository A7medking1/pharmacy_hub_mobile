import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/widget/custom_button.dart';
import 'package:pharmacy_hub/src/features/favorites/data/model/favorites_model.dart';
import 'package:pharmacy_hub/src/features/favorites/logic/favorite_bloc.dart';
import 'package:pharmacy_hub/src/features/home/data/models/product_model.dart';
import 'package:pharmacy_hub/src/features/home/ui/widget/product_card.dart';

class FavoriteIconWidget extends StatefulWidget {
  const FavoriteIconWidget({
    super.key,
    required this.model,
    this.size,
    this.unFavoriteColor,
    this.onTapFavoriteIcon,
    this.index = -1,
  });

  final ProductModel model;
  final void Function()? onTapFavoriteIcon;
  final int index;

  /// TODO  this two params using only in Product Details Screen (  size,  unFavoriteColor )
  final double? size;
  final Color? unFavoriteColor;

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        final FavoriteBloc bloc = context.read<FavoriteBloc>();
        return CustomButton(
          onTap: widget.onTapFavoriteIcon ??
              () {
                _controller.reverse().then((value) => _controller.forward());

                final bool isFav = bloc.favorites[widget.model.id] ?? false;

                if (isFav) {
                  /// TODO that's mean the product if not equal -1 the tapped icon favorite not in favorites screen
                  if (widget.index != -1) {
                    /// TODO when remove product from favorites do some animation
                    context.read<FavoriteBloc>().animatedGrid?.removeItem(
                          widget.index,
                          duration: const Duration(milliseconds: 500),
                          (context, animation) => ScaleTransition(
                            scale: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            ),
                            child: ProductItemWidget(
                              model: state.favoritesItems[widget.index],
                            ),
                          ),
                        );
                  }

                  context.read<FavoriteBloc>().add(
                        RemoveProductFromFavorite(
                          widget.model.id,
                        ),
                      );
                } else {
                  context.read<FavoriteBloc>().add(
                        AddProductToFavoriteEvent(
                          FavoriteItem.fromEntity(
                            widget.model,
                          ),
                        ),
                      );
                }
              },
          width: widget.size ?? 40.h,
          height: widget.size ?? 40.h,
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          padding: EdgeInsets.zero,
          color: AppColors.transparent,
          widget: ScaleTransition(
            scale: Tween(begin: 0.5, end: 1.0).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
              ),
            ),
            child: Icon(
              bloc.favorites[widget.model.id] ?? false
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: bloc.favorites[widget.model.id] ?? false
                  ? AppColors.red
                  : widget.unFavoriteColor ?? AppColors.primary,
              size: widget.size ?? 20.h,
            ),
          ),
        );
      },
    );
  }
}
