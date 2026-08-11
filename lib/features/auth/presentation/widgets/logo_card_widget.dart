// ignore_for_file: deprecated_member_use
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class LogoCardWidget extends StatelessWidget {
  final double width;
  final double height;
  const LogoCardWidget({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(
          offset: const Offset(0, 6),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                AppColors.primary.withOpacity(0.4),
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'assets/images/appIcon.png',
                width: width,
                height: height,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Image.asset(
          'assets/images/appIcon.png',
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
