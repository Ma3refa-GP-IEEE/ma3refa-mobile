// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xff1B4965);
  static const Color secondary = Color(0xff5FA8D3);
  static const Color accent = Color(0xffEAF6F8); //0xFFEAF6F8
  static const Color secondaryBackground = Color(0xffE4E9EB);
  static Color background = Color.lerp(
    const Color(0xFFC9E6FF),
    const Color(0xFFFFFFFF),
    0.2,
  )!;
  static const Color cardSurface = Color(0xffBEE9E8);
  static const Color white = Color(0xffFFFFFF);
  static const Color textDark = Color(0xff1B4965);
  static const Color textLight = Color(0xff41474D);

  static const Color success = Color(0xff2EC4B6);
  static const Color warning = Color(0xffFFB703);
  static const Color error = Color(0xffE63946);
}
/**Color mixedColor = Color.lerp(
  const Color(0xFFFFFFFF), 
  const Color(0xFFC9E6FF), 
  0.5, // نسبة الخلط من 0.0 لـ 1.0
)!; */