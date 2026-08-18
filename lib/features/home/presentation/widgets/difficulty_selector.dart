import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/audio_service.dart';

class DifficultySelector extends StatefulWidget {
  final Function(String) onDifficultySelected;
  const DifficultySelector({super.key, required this.onDifficultySelected});
  @override
  State<DifficultySelector> createState() => _DifficultySelectorState();
}

class _DifficultySelectorState extends State<DifficultySelector> {
  final ValueNotifier<String> selectedDifficultyNotifier = ValueNotifier(
    'Easy',
  );
  @override
  void dispose() {
    selectedDifficultyNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: ValueListenableBuilder<String>(
            valueListenable: selectedDifficultyNotifier,
            builder: (context, currentValue, child) {
              return Row(
                children: [
                  buildDifficultyButton('Easy', currentValue),
                  SizedBox(width: 10.w),
                  buildDifficultyButton('Medium', currentValue),
                  SizedBox(width: 10.w),
                  buildDifficultyButton('Hard', currentValue),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDifficultyButton(String difficulty, String currentValue) {
    bool isSelected = currentValue == difficulty;
    final label = difficulty == 'Easy'
        ? 'home.quizSetup.difficulty.easy'.tr()
        : difficulty == 'Medium'
        ? 'home.quizSetup.difficulty.medium'.tr()
        : 'home.quizSetup.difficulty.hard'.tr();

    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedDifficultyNotifier.value = difficulty;
          widget.onDifficultySelected(difficulty);
          getIt<AudioService>().playAssetSound('sounds/chose_difficulty.wav');
        },
        child:
            AnimatedContainer(
                  height: 70.h,
                  width: 50.w,
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xffBEE9E8),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          difficulty == "Easy"
                              ? Icons.insert_emoticon
                              : difficulty == "Medium"
                              ? Icons.trending_up
                              : Icons.local_fire_department,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF4A5568),
                          size: 24.sp,
                        ),
                        SizedBox(height: 5.h),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            label,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF4A5568),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .animate(target: isSelected ? 1 : 0)
                .scale(
                  end: const Offset(1.05, 1.05),
                  duration: 200.ms,
                  curve: Curves.easeOutBack,
                ),
      ),
    );
  }
}
