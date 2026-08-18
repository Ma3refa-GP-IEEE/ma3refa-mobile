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
          children: [
            Expanded(
              child: _buildStatCard(
                title: "Completed Quizzes",
                value: completedQuizzes.toString(),
                icon: Icons.check_circle_outline_rounded,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildStatCard(
                title: "Total Points",
                value: totalPoints.toString(),
                icon: Icons.stars_rounded,
              ),
            ),
          ],
        )
        .animate(delay: 200.ms)
        .fadeIn(duration: 400.ms, curve: Curves.easeInOutCirc)
        .slideY(begin: 0.1, duration: 400.ms, curve: Curves.easeOut);
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
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
          Icon(icon, color: AppColors.primary.withOpacity(0.5), size: 24.sp),
          SizedBox(height: 12.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
