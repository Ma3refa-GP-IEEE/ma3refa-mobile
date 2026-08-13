// ignore_for_file: deprecated_member_use

import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class DailyStreakWidget extends StatefulWidget {
  final int streakCount;

  const DailyStreakWidget({super.key, required this.streakCount});

  @override
  State<DailyStreakWidget> createState() => _DailyStreakWidgetState();
}

class _DailyStreakWidgetState extends State<DailyStreakWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    if (widget.streakCount > 0) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant DailyStreakWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.streakCount != oldWidget.streakCount) {
      if (widget.streakCount > 0) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.reset();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isStreakActive = widget.streakCount > 0;

    final Color activeFireColor = const Color(0xFFFF9E59);
    final Color inactiveFireColor = Colors.grey.shade400;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 24.r, horizontal: 48.r),
        decoration: BoxDecoration(
          color: Color(0xffA8DADC),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final double shakeOffset = isStreakActive
                      ? math.sin(_controller.value * math.pi * 2) * 2.0
                      : 0.0;

                  return Transform.translate(
                    offset: Offset(shakeOffset, 0),
                    child: Icon(
                      Icons.local_fire_department_rounded,
                      size: 64.sp,
                      color: isStreakActive
                          ? activeFireColor
                          : inactiveFireColor,
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h),
              Text(
                'days'.tr(namedArgs: {'count': widget.streakCount.toString()}),
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
    );
  }
}
