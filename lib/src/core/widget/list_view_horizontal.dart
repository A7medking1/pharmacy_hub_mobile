import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/size_manager.dart';

class ListViewHorizontal extends StatelessWidget {
  final double? height;
  final double? width;
  final int count;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final bool isHasViewAllWidget;
  final void Function()? onTapViewAll;
  final EdgeInsetsGeometry? padding;
  final Object tag;

  const ListViewHorizontal({
    super.key,
    this.height,
    required this.count,
    required this.itemBuilder,
    this.separatorBuilder,
    this.width,
    this.isHasViewAllWidget = true,
    this.onTapViewAll,
    this.padding,required this.tag,
  }) : assert(isHasViewAllWidget || onTapViewAll == null,
  'If isHasViewAllWidget is false, onTapViewAll must be null.');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding:
        padding ?? EdgeInsets.symmetric(horizontal: AppSize.pagePadding.w),
        itemCount: isHasViewAllWidget ? count + 1 : count,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (isHasViewAllWidget && index == count) {
            return ViewAllWidget(onTap: onTapViewAll, tag: tag,);
          }
          return itemBuilder(context, index);
        },
        separatorBuilder: separatorBuilder ??
                (BuildContext context, int index) {
              return SizedBox(width: 15.w);
            },
      ),
    );
  }
}

class ViewAllWidget extends StatelessWidget {
  const ViewAllWidget({super.key, required this.onTap, required this.tag});

  final void Function()? onTap;
  final Object tag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: CircleAvatar(
                    radius: 30.h,
                    backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 30.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                FittedBox(
                  child: Text(
                    "view all",
                    style: context.titleSmall.copyWith(
                      fontSize: 13.sp,
                    ),
                    // color: ColorManager.white,
                    //  lightColor: ColorManager.black,
                    //  fontSize: 12,
                    ///  fontWeight: FontWeight.w400,
                    //  fontFamily: "Regular",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
