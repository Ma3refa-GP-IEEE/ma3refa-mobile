// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class DailyStreakWidget extends StatefulWidget {
  final int streakCount;

  const DailyStreakWidget({super.key, required this.streakCount});

  @override
  State<DailyStreakWidget> createState() => _DailyStreakWidgetState();
}

class _DailyStreakWidgetState extends State<DailyStreakWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isStreakActive = widget.streakCount > 0;

    final Color activeFireColor = const Color(0xFFFF9E59);
    final Color inactiveFireColor = Colors.grey.shade400;

    Widget fireIcon = Icon(
      Icons.local_fire_department_rounded,
      size: 64.sp,
      color: isStreakActive ? activeFireColor : inactiveFireColor,
    );

    if (isStreakActive) {
      fireIcon = fireIcon
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.15, 1.15),
            duration: 800.ms,
            curve: Curves.easeInOut,
          )
          .shimmer(color: Colors.white.withOpacity(0.3), duration: 1.seconds);
    }

    return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          elevation: 4,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.r, horizontal: 48.r),
            decoration: BoxDecoration(
              color: const Color(0xffA8DADC),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  fireIcon,
                  SizedBox(height: 12.h),
                  Text(
                    'days'.tr(
                      namedArgs: {'count': widget.streakCount.toString()},
                    ),
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'daily_streak'.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark.withOpacity(0.7),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fade(duration: 400.ms)
        .scale(
          begin: const Offset(0.9, 0.9),
          curve: Curves.easeOutBack,
          duration: 400.ms,
        );
  }
}
