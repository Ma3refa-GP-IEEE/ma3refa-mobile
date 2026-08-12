// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class AnswerOptionWidget extends StatefulWidget {
  final List<String> answers;
  final String selectedAnswer;
  final Function(String) onOptionSelected;
  const AnswerOptionWidget({
    super.key,
    required this.answers,
    required this.selectedAnswer,
    required this.onOptionSelected,
  });

  @override
  State<AnswerOptionWidget> createState() => _AnswerOptionWidgetState();
}

class _AnswerOptionWidgetState extends State<AnswerOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.answers.length, (index) {
        String currentOption = widget.answers[index];
        bool isSelected = currentOption == widget.selectedAnswer;
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 15.h),
          child: ElevatedButton(
            onPressed: () {
              widget.onOptionSelected(currentOption);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected
                  ? AppColors.primary.withOpacity(0.15)
                  : AppColors.cardSurface,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              elevation: isSelected ? 4 : 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: isSelected
                    ? BorderSide(color: AppColors.primary, width: 1.5)
                    : BorderSide.none,
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 12.w),
                Container(
                  height: 24.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget.answers[index],
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textDark,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
              ],
            ),
          ),
        );
      }),
    );
  }
}
