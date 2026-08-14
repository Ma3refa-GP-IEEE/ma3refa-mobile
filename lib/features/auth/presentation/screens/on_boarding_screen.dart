// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/logo_card_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle subtitleStyle = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.textLight,
      height: 1.5,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogoCardWidget(width: 256.w, height: 288.h)
                    .animate()
                    .fade(duration: 600.ms)
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      curve: Curves.easeOutBack,
                    ),
                SizedBox(height: 25.h),

                Text(
                      'onboarding_title'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    )
                    .animate(delay: 300.ms)
                    .fade(duration: 500.ms)
                    .slideY(begin: 0.2),

                SizedBox(height: 20.h),

                SizedBox(
                  height: 60.h,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Text(
                            'onboarding_subtitle2'.tr(),
                            textAlign: TextAlign.center,
                            style: subtitleStyle,
                          )
                          .animate()
                          .fadeIn(duration: 500.ms)
                          .fadeOut(delay: 2.seconds, duration: 500.ms), // تختفي

                      Text(
                            'onboarding_subtitle3'.tr(),
                            textAlign: TextAlign.center,
                            style: subtitleStyle,
                          )
                          .animate(delay: 2.5.seconds)
                          .fadeIn(duration: 500.ms)
                          .fadeOut(delay: 2.seconds, duration: 500.ms), // تختفي

                      Text(
                        'onboarding_subtitle4'.tr(),
                        textAlign: TextAlign.center,
                        style: subtitleStyle,
                      ).animate(delay: 5.seconds).fadeIn(duration: 500.ms),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                CustomButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      text: 'get_started'.tr(),
                      icon: Icons.arrow_forward,
                    )
                    .animate(delay: 6.seconds)
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.5, curve: Curves.easeOutBack),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
