// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_cubit.dart';

class ErrorHomeWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorHomeWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                  Icons.wifi_off_rounded,
                  size: 100.r,
                  color: AppColors.primary.withOpacity(0.8),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .scaleXY(end: 1.1, duration: 1.seconds, curve: Curves.easeInOut)
                .fade(duration: 500.ms),

            SizedBox(height: 20.h),
            Text(
                  'Oops! Something went wrong.'.tr(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                )
                .animate()
                .slideY(begin: 0.3, duration: 500.ms, curve: Curves.easeOutBack)
                .fade(duration: 500.ms),

            SizedBox(height: 10.h),
            Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, color: AppColors.textLight),
                )
                .animate()
                .slideY(
                  begin: 0.3,
                  delay: 100.ms,
                  duration: 500.ms,
                  curve: Curves.easeOutBack,
                )
                .fade(duration: 500.ms, delay: 100.ms),

            SizedBox(height: 40.h),
            SizedBox(
                  width: 200.w,
                  child: CustomButton(
                    onPressed: () {
                      BlocProvider.of<HomeCubit>(
                        context,
                      ).getAllHomeCategories();
                    },
                    text: 'Retry'.tr(),
                    icon: Icons.refresh_rounded,
                  ),
                )
                .animate()
                .scale(
                  delay: 200.ms,
                  duration: 400.ms,
                  curve: Curves.easeOutBack,
                )
                .fade(delay: 200.ms),
          ],
        ),
      ),
    );
  }
}
