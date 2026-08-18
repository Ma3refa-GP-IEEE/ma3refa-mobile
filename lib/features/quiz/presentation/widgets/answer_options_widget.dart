// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class AnswerOptionWidget extends StatefulWidget {
  final List<String> answers;
  final String? selectedAnswer;
  final Function(String) onOptionSelected;

  final bool isAnswered;
  final String? correctAnswer;

  const AnswerOptionWidget({
    super.key,
    required this.answers,
    required this.selectedAnswer,
    required this.onOptionSelected,
    this.isAnswered = false,
    this.correctAnswer,
  });

  @override
  State<AnswerOptionWidget> createState() => _AnswerOptionWidgetState();
}

class _AnswerOptionWidgetState extends State<AnswerOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.answers.length, (index) {
        String currentLetter = String.fromCharCode(97 + index);
        String currentOption = widget.answers[index];
        bool isSelected = currentLetter == widget.selectedAnswer;
        bool isCorrect = currentLetter == widget.correctAnswer?.toLowerCase();
        bool isWrongSelection = isSelected && !isCorrect;

        Color getBorderColor() {
          if (!widget.isAnswered) {
            return isSelected ? AppColors.primary : Colors.transparent;
          }
          if (isCorrect) return Colors.green;
          if (isWrongSelection) return Colors.red;
          return Colors.transparent;
        }

        Color getBackgroundColor() {
          if (!widget.isAnswered) {
            return isSelected
                ? AppColors.primary.withOpacity(0.15)
                : AppColors.cardSurface;
          }
          if (isCorrect) return Colors.green.withOpacity(0.15);
          if (isWrongSelection) return Colors.red.withOpacity(0.15);
          return AppColors.cardSurface;
        }

        Color getCircleColor() {
          if (!widget.isAnswered) {
            return isSelected ? AppColors.primary : Colors.grey.shade400;
          }
          if (isCorrect) return Colors.green;
          if (isWrongSelection) return Colors.red;
          return Colors.grey.shade400;
        }

        Color getTextColor() {
          if (!widget.isAnswered) {
            return isSelected ? AppColors.primary : AppColors.textDark;
          }
          if (isCorrect) return Colors.green;
          if (isWrongSelection) return Colors.red;
          return AppColors.textDark;
        }

        Widget getLeadingIcon() {
          if (widget.isAnswered && isCorrect) {
            return Icon(Icons.check, color: Colors.white, size: 16.sp);
          } else if (widget.isAnswered && isWrongSelection) {
            return Icon(Icons.close, color: Colors.white, size: 16.sp);
          }
          return Text(
            String.fromCharCode(65 + index),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }

        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 15.h),
          child: ElevatedButton(
            onPressed: () {
              if (!widget.isAnswered) {
                widget.onOptionSelected(currentOption);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: getBackgroundColor(),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              elevation: isSelected && !widget.isAnswered ? 6 : 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: getBorderColor() != Colors.transparent
                    ? BorderSide(color: getBorderColor(), width: 1.5)
                    : BorderSide.none,
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 12.w),
                Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    color: getCircleColor(),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: getLeadingIcon()),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.answers[index],
                      style: TextStyle(fontSize: 16.sp, color: getTextColor()),
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
