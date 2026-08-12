// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
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
      margin: EdgeInsets.all(10),
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
              border: Border.all(color: getCirculeColor(), width: 4.r),
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
                    'Score',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32.h),
          Row(
            children: [
              _buildAnsContainer(
                numOfAnswers: correctAnswers,
                label: 'Correct',
                color: const Color(0xFF2E7D32),
              ),
              SizedBox(width: 16.w),
              _buildAnsContainer(
                numOfAnswers: wrongAnswers,
                label: 'Wrong',
                color: const Color(0xFFC62828),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _buildAnsContainer({
    required int numOfAnswers,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFC8E6C9), width: 1),
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
                color: label == 'Correct'
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFFC62828),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
