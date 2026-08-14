// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizScoreCardWidget extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  const QuizScoreCardWidget({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    int percentage = totalQuestions > 0
        ? ((correctAnswers / totalQuestions) * 100).round()
        : 0;

    int wrongAnswers = totalQuestions - correctAnswers;
    const List<Map<int, Color>> colorsBasedOnPercentage = [
      {90: Color(0xFF4CAF50)},
      {70: Color(0xFFFFEB3B)},
      {50: Color(0xFFF44336)},
      {0: Color(0xFF9E9E9E)},
    ];

    Color getCirculeColor() {
      for (var colorMap in colorsBasedOnPercentage) {
        final key = colorMap.keys.first;
        if (percentage >= key) {
          return colorMap[key]!;
        }
      }
      return Colors.grey;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      margin: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
                height: 140.h,
                width: 140.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: getCirculeColor(), width: 4.w),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$percentage%',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: getCirculeColor(),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'score_label'.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .animate()
              .scale(
                begin: const Offset(0.5, 0.5),
                duration: 500.ms,
                curve: Curves.easeOutBack,
              )
              .then(delay: 200.ms)
              .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.05, 1.05),
                duration: 800.ms,
                curve: Curves.easeInOut,
              )
              .then()
              .scale(
                begin: const Offset(1.05, 1.05),
                end: const Offset(1.0, 1.0),
                duration: 800.ms,
                curve: Curves.easeInOut,
              ),
          SizedBox(height: 32.h),
          Row(
            children: [
              _buildAnsContainer(
                    numOfAnswers: correctAnswers,
                    label: 'correct_label'.tr(),
                    color: const Color(0xFF2E7D32),
                    bgColor: const Color(0xFFE8F5E9),
                    borderColor: const Color(0xFFC8E6C9),
                  )
                  .animate(delay: 300.ms)
                  .fade(duration: 400.ms)
                  .slideX(begin: -0.2, curve: Curves.easeOut),
              SizedBox(width: 16.w),
              _buildAnsContainer(
                    numOfAnswers: wrongAnswers,
                    label: 'wrong_label'.tr(),
                    color: const Color(0xFFC62828),
                    bgColor: const Color(0xFFFFEBEE),
                    borderColor: const Color(0xFFFFCDD2),
                  )
                  .animate(delay: 300.ms)
                  .fade(duration: 400.ms)
                  .slideX(begin: 0.2, curve: Curves.easeOut),
            ],
          ),
        ],
      ),
    ).animate().fade(duration: 400.ms);
  }

  Expanded _buildAnsContainer({
    required int numOfAnswers,
    required String label,
    required Color color,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          children: [
            Text(
              '$numOfAnswers',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
