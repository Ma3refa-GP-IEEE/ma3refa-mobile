// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/home/data/models/sub_category_model.dart';

class CustomListTileWidget extends StatelessWidget {
  final SubCategoryModel subCategory;
  const CustomListTileWidget({super.key, required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffBEE9E8),
      //margin: EdgeInsets.all(10.r),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.r),
        leading: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(subCategory.icon, color: AppColors.textDark, size: 28.sp),
        ),
        // leading: Icon(subCategory.icon, size: 40.sp, color: AppColors.primary),
        title: Text(
          subCategory.name,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        subtitle: Text(
          subCategory.description,
          style: TextStyle(fontSize: 14.sp, color: AppColors.textLight),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textDark),
      ),
    );
  }
}
