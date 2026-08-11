// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumberOfQuestionWidget extends StatefulWidget {
  final Function(int) onNumberOfQuestionsSelected;
  const NumberOfQuestionWidget({
    super.key,
    required this.onNumberOfQuestionsSelected,
  });

  @override
  State<NumberOfQuestionWidget> createState() => _NumberOfQuestionWidgetState();
}

class _NumberOfQuestionWidgetState extends State<NumberOfQuestionWidget> {
  double _currentValue = 10;

  final Color darkBlueText = const Color(0xFF1B4B67);
  final Color activeSliderColor = const Color(0xFF67A4CA);
  final Color inactiveSliderColor = const Color(0xFFC7EBE6);
  final Color cardColor = const Color(0xFFF1F7FC);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(
            bottom: 10.r,
            left: 10.r,
            right: 16.r,
            top: 16.r,
          ),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10.r,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'home.quizSetup.numberOfQuestions'.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: darkBlueText,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                decoration: BoxDecoration(
                  color: inactiveSliderColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _currentValue.toInt() > 10
                      ? '${_currentValue.toInt()} ${'home.quizSetup.question'.tr()}'
                      : '${_currentValue.toInt()} ${'home.quizSetup.questions'.tr()}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: darkBlueText,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 15.r),

        SliderTheme(
          data: SliderThemeData(
            trackHeight: 6.0,
            activeTrackColor: activeSliderColor,
            inactiveTrackColor: inactiveSliderColor,
            thumbColor: darkBlueText,
            overlayColor: darkBlueText.withOpacity(0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
            trackShape: const RoundedRectSliderTrackShape(),
          ),
          child: Slider(
            value: _currentValue,
            min: 5,
            max: 20,
            divisions: 15,
            onChanged: (value) {
              setState(() {
                _currentValue = value;
                widget.onNumberOfQuestionsSelected(value.toInt());
              });
            },
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSliderLabel('5'),
              _buildSliderLabel('10'),
              _buildSliderLabel('15'),
              _buildSliderLabel('20'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliderLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: darkBlueText.withOpacity(0.8),
      ),
    );
  }
}
