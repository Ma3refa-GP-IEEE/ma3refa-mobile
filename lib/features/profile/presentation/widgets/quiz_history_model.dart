// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizHistoryCard extends StatelessWidget {
  final int difficulty;
  final int score;
  final int totalQuestions;
  final String createdAt;
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

  Map<String, dynamic> _getDifficultyDetails(int difficulty) {
    switch (difficulty) {
      case 1:
        return {
          'text': 'Easy',
          'color': const Color(0xFFE8F5E9),
          'textColor': const Color(0xFF2E7D32),
        };
      case 2:
        return {
          'text': 'Medium',
          'color': const Color(0xFFD0F0FD),
          'textColor': const Color(0xFF133F53),
        };
      case 3:
        return {
          'text': 'Hard',
          'color': const Color(0xFFFFEBEE),
          'textColor': const Color(0xFFC62828),
        };
      default:
        return {
          'text': 'Unknown',
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

  Map<String, String> _formatDateTime(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      final date =
          "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";

      int hour = dateTime.hour;
      final period = hour >= 12 ? "PM" : "AM";
      hour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final time = "$hour:$minute $period";
      return {'date': date, 'time': time};
    } catch (e) {
      return {'date': '--', 'time': '--'};
    }
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = (score / totalQuestions) * 100;
    final Color scoreColor = _getScoreColor(percentage);

    final diff = _getDifficultyDetails(difficulty);
    final dateTimeMap = _formatDateTime(createdAt);

    final Color mainTextColor = const Color(0xFF133F53);
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        elevation: 0,
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
                              '$score/$totalQuestions',
                              style: TextStyle(
                                color: scoreColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
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
                    Text(
                      dateTimeMap['date']!,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: mainTextColor.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      dateTimeMap['time']!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14.sp,
                      color: Colors.grey.shade400,
                    ),
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
