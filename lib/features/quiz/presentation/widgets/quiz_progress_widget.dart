import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizProgressWidget extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const QuizProgressWidget({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    double targetProgress = (currentQuestion / totalQuestions).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 20.r),
      color: const Color(0xFFD4EAFC),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Text(
                'Question $currentQuestion of $totalQuestions',
                style: TextStyle(
                  color: Color(0xFF1B4D6A),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: targetProgress),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              builder: (context, value, _) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 10.h,
                  backgroundColor: const Color(0xFFC7EBE3),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF67B0C6),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
