import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';

class CustomListTileWidget extends StatelessWidget {
  final String? title;
  final String? leadingIcon;
  final Color? fontColor;
  final Widget? trailingWidget;
  final void Function()? onTap;
  final TextStyle? style;

  const CustomListTileWidget({
    super.key,
    this.onTap,
    this.leadingIcon,
    this.trailingWidget,
    this.fontColor,
    this.title,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: 20,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.backGroundColor,
            borderRadius: BorderRadiusDirectional.circular(20)),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsetsDirectional.only(start: 15),
            child: Text(
              title!,
              style: style ??
                  Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 14.sp,
                        fontFamily: CustomFontFamily.vazirmatn,
                        color: fontColor ?? AppColors.defaultTextColor,
                      ),
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: trailingWidget ??
                const Icon(
                  Icons.keyboard_arrow_right,
                  size: 22,
                  color: Color(0xFF3A3A3A),
                ),
          ),
        ),
      ),
    );
  }
}
