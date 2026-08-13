import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class GenderSelector extends StatefulWidget {
  final Function(String) onGenderSelected;
  const GenderSelector({super.key, required this.onGenderSelected});
  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  final ValueNotifier<String> selectedGenderNotifier = ValueNotifier('Male');
  @override
  void dispose() {
    selectedGenderNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            'gender_label'.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF0F2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: ValueListenableBuilder<String>(
            valueListenable: selectedGenderNotifier,
            builder: (context, currentValue, child) {
              return Row(
                children: [
                  buildGenderButton('Male', currentValue, 'male_option'.tr()),
                  SizedBox(width: 10.w),
                  buildGenderButton(
                    'Female',
                    currentValue,
                    'female_option'.tr(),
                  ),
                  SizedBox(width: 10.w),
                  buildGenderButton('Other', currentValue, 'other_option'.tr()),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildGenderButton(String gender, String currentValue, String label) {
    bool isSelected = currentValue == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedGenderNotifier.value = gender;
          widget.onGenderSelected(gender);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.accent,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : const Color(0xFF4A5568),
            ),
          ),
        ),
      ),
    );
  }
}
