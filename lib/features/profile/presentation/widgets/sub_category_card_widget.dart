import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class SubCategoryCardWidget extends StatelessWidget {
  final String subcategory;
  final int subcategoryPoint;
  final IconData icon;
  const SubCategoryCardWidget({
    super.key,
    required this.subcategory,
    required this.subcategoryPoint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle tap on the subcategory card
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        color: Color(0xffA8DADC),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        child: ListTile(
          leading: Icon(icon, size: 30.sp, color: AppColors.primary),
          title: Text(
            subcategory,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          subtitle: Text(
            'total_points'.tr(
              namedArgs: {'points': subcategoryPoint.toString()},
            ),
            style: TextStyle(fontSize: 14.sp, color: AppColors.textLight),
          ),
          trailing: RatingTrailingWidget(currentPoints: subcategoryPoint),
        ),
      ),
    );
  }
}

class RatingTrailingWidget extends StatelessWidget {
  final int currentPoints;

  const RatingTrailingWidget({super.key, required this.currentPoints});

  @override
  Widget build(BuildContext context) {
    double maxPoints = 500.0;
    double rating = (currentPoints / maxPoints) * 5.0;
    rating = rating.clamp(0.0, 5.0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.star_rounded, color: Colors.amber, size: 28.sp),
        SizedBox(width: 4.w),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}
