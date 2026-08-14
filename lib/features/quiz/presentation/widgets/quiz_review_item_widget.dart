import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizReviewItemWidget extends StatefulWidget {
  final int questionNumber;
  final String questionText;
  final String correctAnswer;
  final String userAnswer;
  final String explanation;
  final bool isCorrect;

  const QuizReviewItemWidget({
    super.key,
    required this.questionNumber,
    required this.questionText,
    required this.correctAnswer,
    required this.userAnswer,
    required this.explanation,
    required this.isCorrect,
  });

  @override
  State<QuizReviewItemWidget> createState() => _QuizReviewItemWidgetState();
}

class _QuizReviewItemWidgetState extends State<QuizReviewItemWidget> {
  late bool _isExpanded;
  late bool _isCorrect;
  late bool _isSkipped;

  @override
  void initState() {
    super.initState();
    _isCorrect = widget.isCorrect;
    _isExpanded = !_isCorrect;
    final normalizedAnswer = widget.userAnswer.trim().toLowerCase();
    _isSkipped = normalizedAnswer == 'skipped';
  }

  @override
  Widget build(BuildContext context) {
    final cardBgColor = widget.isCorrect
        ? const Color(0xFFE8F5E9)
        : _isSkipped
        ? const Color(0xFFFFEBEE)
        : const Color(0xFFFFEBEE);
    final themeColor = widget.isCorrect
        ? const Color(0xFF2E7D32)
        : _isSkipped
        ? const Color(0xFFC62828)
        : const Color(0xFFC62828);
    final iconData = widget.isCorrect ? Icons.check_circle : Icons.cancel;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: _isCorrect
              ? const Color(0xFFC8E6C9)
              : _isSkipped
              ? const Color(0xFFFFCDD2)
              : const Color(0xFFFFCDD2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(iconData, color: themeColor, size: 22.sp),
                    SizedBox(width: 8.w),
                    Text(
                      '${'question_label'.tr()} ${widget.questionNumber}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                Text(
                  widget.questionText,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B4D6A),
                  ),
                ),
                SizedBox(height: 16.h),

                if (!widget.isCorrect) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    margin: EdgeInsets.only(bottom: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      !_isSkipped
                          ? 'your_answer'.tr(
                              namedArgs: {'answer': widget.userAnswer},
                            )
                          : 'you_skipped_question'.tr(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFC62828),
                      ),
                    ),
                  ),
                ],

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'correct_answer'.tr(
                      namedArgs: {'answer': widget.correctAnswer},
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            color: _isCorrect
                ? const Color(0xFFC8E6C9)
                : const Color(0xFFFFCDD2),
            height: 1,
          ),

          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'view_explanation'.tr(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: themeColor,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: cardBgColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: themeColor,
                        size: 18.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'explanation_label'.tr(),
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    widget.explanation,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}
