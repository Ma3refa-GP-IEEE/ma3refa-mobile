// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class LogoCardWidget extends StatelessWidget {
  final double width;
  final double height;
  const LogoCardWidget({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      elevation: 8,
      shadowColor: AppColors.primary.withOpacity(0.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: Image.asset(
          'assets/images/OnBoardingLogo.jpeg',
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
