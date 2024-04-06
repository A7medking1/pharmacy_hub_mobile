import 'package:flutter/material.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';

AppBar buildAppBar({
  required BuildContext context,
  required String title,
  Widget? leading,
  Widget? actionButton = const SizedBox.shrink(),
}) {
  return AppBar(
    leading: leading,
    actions: [actionButton!],
    title: Text(
      title,
      style: context.titleSmall.copyWith(
        fontFamily: CustomFontFamily.vazirmatn,
      ),
    ),
  );
}
