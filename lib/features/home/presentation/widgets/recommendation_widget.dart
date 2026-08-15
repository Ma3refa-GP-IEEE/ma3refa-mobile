import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';

class RecommendationWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const RecommendationWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 15.r),
        width: 280.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'home.recommendation.title'.tr(),
                style: TextStyle(fontSize: 18.sp, color: AppColors.primary),
              ),
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'home.recommendation.description'.tr(),
                style: TextStyle(fontSize: 14.sp, color: AppColors.textLight),
              ),
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'home.recommendation.difficulty'.tr(),
                style: TextStyle(fontSize: 14.sp, color: AppColors.textLight),
              ),
            ),
            SizedBox(height: 10.h),
            CustomButton(
              onPressed: () {},
              text: 'home.recommendation.playQuiz'.tr(),
              icon: Icons.play_arrow,
            ),
          ],
        ),
      ),
    );
  }
}
