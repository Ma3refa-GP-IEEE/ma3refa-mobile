// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class SummaryWidget extends StatelessWidget {
  final int completedQuizzes;
  final int totalPoints;
  const SummaryWidget({
    super.key,
    required this.completedQuizzes,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 170.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.primary.withOpacity(0.2),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  children: [
                    Text(
                      "Completed Quizzes",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "$completedQuizzes",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 170.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.secondary.withOpacity(0.2),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  children: [
                    Text(
                      "Total Points",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "$totalPoints",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
        .animate(delay: 200.ms)
        .fadeIn(duration: 400.ms, curve: Curves.easeInOutCirc);
  }
}
