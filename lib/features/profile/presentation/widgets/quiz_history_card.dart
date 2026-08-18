// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class QuizHistoryCard extends StatelessWidget {
  final String difficulty;
  final int score;
  final int totalQuestions;
  final DateTime? createdAt;
  final String quizTitle;
  final VoidCallback onTap;

  const QuizHistoryCard({
    super.key,
    required this.quizTitle,
    required this.onTap,
    required this.difficulty,
    required this.score,
    required this.totalQuestions,
    required this.createdAt,
  });

  Map<String, dynamic> _getDifficultyDetails(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return {
          'text': "Easy",
          'color': const Color(0xFFE8F5E9),
          'textColor': const Color(0xFF2E7D32),
        };
      case 'medium':
        return {
          'text': "Medium",
          'color': const Color(0xFFD0F0FD),
          'textColor': const Color(0xFF133F53),
        };
      case 'hard':
        return {
          'text': "Hard",
          'color': const Color(0xFFFFEBEE),
          'textColor': const Color(0xFFC62828),
        };
      default:
        return {
          'text': "Unknown",
          'color': Colors.grey.shade200,
          'textColor': Colors.grey,
        };
    }
  }

  Color _getScoreColor(double percentage) {
    const List<Map<int, Color>> colorsBasedOnPercentage = [
      {90: Color(0xFF4CAF50)},
      {70: Color(0xFFFBC02D)},
      {50: Color(0xFFF44336)},
      {0: Color(0xFF9E9E9E)},
    ];

    for (var map in colorsBasedOnPercentage) {
      int minPercentage = map.keys.first;
      if (percentage >= minPercentage) {
        return map.values.first;
      }
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final int difficultyLevel = difficulty.toLowerCase() == 'easy'
        ? 1
        : difficulty.toLowerCase() == 'medium'
        ? 2
        : 3;
    final numOfCorrectAnswers = score ~/ difficultyLevel;
    final double percentage = (numOfCorrectAnswers / totalQuestions) * 100;
    final Color scoreColor = _getScoreColor(percentage);

    final diff = _getDifficultyDetails(difficulty);

    final Color mainTextColor = const Color(0xFF133F53);

    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade200, width: 1.w),
          borderRadius: BorderRadius.circular(24.r),
        ),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(24.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        quizTitle,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: mainTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: scoreColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Text(
                                  '$numOfCorrectAnswers / $totalQuestions',
                                  style: TextStyle(
                                    color: scoreColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              )
                              .animate(delay: 200.ms)
                              .scale(
                                begin: const Offset(0.5, 0.5),
                                curve: Curves.easeOutBack,
                                duration: 400.ms,
                              )
                              .fadeIn(),

                          SizedBox(width: 10.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.r,
                              vertical: 6.r,
                            ),
                            decoration: BoxDecoration(
                              color: diff['color'],
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              diff['text'],
                              style: TextStyle(
                                color: diff['textColor'],
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 50.h,
                  width: 1.w,
                  color: Colors.grey.shade300,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (createdAt != null) ...[
                      Text(
                        DateFormat('yyyy-MM-dd').format(createdAt!),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: mainTextColor.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${DateFormat('hh:mm a').format(createdAt!)}\n${timeago.format(createdAt!)}",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ] else
                      Text(
                        'Date unavailable',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
