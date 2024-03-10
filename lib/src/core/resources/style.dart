import 'package:flutter/material.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/core/resources/font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}
// light style

TextStyle getLightStyle({
  double fontSize = FontSize.s18,
  Color color = AppColors.defaultTextColor,
}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// regular style

TextStyle getRegularStyle({
  double fontSize = FontSize.s18,
  Color color = AppColors.defaultTextColor,
}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// medium style

TextStyle getMediumStyle({
  double fontSize = FontSize.s18,
  Color color = AppColors.defaultTextColor,
}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// semi bold style

TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s18,
  Color color = AppColors.defaultTextColor,
}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
// bold style

TextStyle getBoldStyle({
  double fontSize = FontSize.s18,
  Color color = AppColors.defaultTextColor,
}) {
  return _getTextStyle(
    fontSize,
    FontWeightManager.bold,
    color,
  );
}
