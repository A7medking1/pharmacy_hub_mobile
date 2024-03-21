import 'dart:ui';

import 'package:flutter/material.dart';

/// TODO Light COLOR

class AppColors {
  static const Color primary = Color(0xFF6AB784);
  static const Color palePrimary = Color.fromARGB(255, 139, 182, 153); /* باهت */
  static const Color primaryWithOp = Color(0xFF60A47A);
  static const Color backGroundColor = Color(0xFFFAFAFA);
  static const Color defaultTextColor = Color(0xFF1D1D1D);
  static const Color formFieldColor = Color(0xFF262626);

  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);
  static Color black = const Color(0xff000000);

  static const redWIthOp = Color(0x1AFF0000);
  static const red = Color(0xBBFF0000);
  static const greenWIthOp = Color(0x1A34C47C);
  static const green = Color(0xBB34C47C);

  static Color yellowLight = const Color(0xFFFFF4D0);
  static Color yellowDark = const Color(0xFFF5DF99);

  static Color grey1 = const Color(0xff707070);
  static Color grey2 = const Color(0xff797979);
  static const Color white = Color(0xffFFFFFF);
  static Color white2 = const Color(0xCCdde1e3);
  static const Color transparent = Colors.transparent;
  static Gradient get shimmerColor =>
      LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight ,colors: [black.withOpacity(.2), white.withOpacity(.1), black.withOpacity(.2)], stops: const [.3, .4, .5]);
}
