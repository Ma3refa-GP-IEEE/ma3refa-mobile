// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class DailyStreakWidget extends StatefulWidget {
  final DateTime? lastActivity;
  final int streakCount;

  const DailyStreakWidget({
    super.key,
    required this.streakCount,
    required this.lastActivity,
  });

  @override
  State<DailyStreakWidget> createState() => _DailyStreakWidgetState();
}

class _DailyStreakWidgetState extends State<DailyStreakWidget> {
  @override
  Widget build(BuildContext context) {
    final String timeFormated = widget.lastActivity != null
        ? DateFormat('yyyy-MM-dd').format(widget.lastActivity!)
        : "";
    final bool isStreakActive = widget.streakCount > 0;

    return InkWell(
      onTap: () {
        getIt<AudioService>().playAssetSound('sounds/streak_sound.mp3');
      },
      borderRadius: BorderRadius.circular(24.r),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        child:
            Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 24.h,
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isStreakActive
                          ? Lottie.asset(
                              'assets/lottie/fire.json',
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.contain,
                            )
                          : Icon(
                              Icons.local_fire_department_rounded,
                              size: 64.sp,
                              color: Colors.grey.shade300,
                            ),
                      SizedBox(height: 12.h),
                      Text(
                        'days'.tr(
                          namedArgs: {'count': widget.streakCount.toString()},
                        ),
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'daily_streak'.tr().toUpperCase(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.orange.shade700,
                          letterSpacing: 1.5,
                        ),
                      ),
                      if (widget.lastActivity != null) ...[
                        SizedBox(height: 10.h),
                        Divider(
                          color: Colors.grey.shade200,
                          thickness: 1,
                          indent: 40.w,
                          endIndent: 40.w,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Last Activity: $timeFormated",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          timeago.format(widget.lastActivity!),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ],
                  ),
                )
                .animate()
                .fade(duration: 400.ms)
                .scale(
                  begin: const Offset(0.9, 0.9),
                  curve: Curves.easeOutBack,
                  duration: 400.ms,
                ),
      ),
    );
  }
}
