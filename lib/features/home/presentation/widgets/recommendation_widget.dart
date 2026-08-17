// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';

class RecommendationWidget extends StatelessWidget {
  final String topicTitle;
  final String difficultyLevel;
  final String subCategoryTitle;
  final int subCategoryId;
  final VoidCallback onTap;

  RecommendationWidget({
    super.key,
    required this.onTap,
    required this.topicTitle,
    required this.difficultyLevel,
    required this.subCategoryTitle,
    required this.subCategoryId,
  });

  int quizTime = 10;
  int numberOfQuestions = 10;

  Color getDiffColor(String difficulty) {
    String temp = difficulty.toLowerCase();
    switch (temp) {
      case 'easy':
        return Colors.greenAccent;
      case 'medium':
        return Colors.orangeAccent;
      case 'hard':
        return Colors.redAccent;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r), // تطابق مع البوردر
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        // تم مسح العرض (width) لأن الكاروسيل بيتولى الموضوع
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          // إضافة ظل شيك بيخلي الكارت يبرز لبره
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    subCategoryTitle,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  decoration: BoxDecoration(
                    color: getDiffColor(difficultyLevel),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    child: Text(
                      difficultyLevel,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              "Sugested topic/s: $topicTitle",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textLight,
                height: 1.4,
              ),
              maxLines: 2, // قللت الـ lines عشان المساحة تبقى أريح للزرار
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            CustomButton(
              onPressed: onTap,
              text: 'home.recommendation.playQuiz'.tr(),
              icon: Icons.play_arrow,
            ),
          ],
        ),
      ),
    );
  }
}
