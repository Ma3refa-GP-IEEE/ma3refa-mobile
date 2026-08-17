// ignore_for_file: deprecated_member_use

import 'dart:ui'; // مهم جداً للـ Blur Effect
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/home/data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;
  final double? height; // تم إضافة الطول لاستخدامه في الـ Masonry

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Container(
          height: height, // تطبيق الطول المتغير
          decoration: BoxDecoration(
            // ندي اللون شفافية عشان تأثير الزجاج يشتغل
            color: category.color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(24.r),
            // حدود بيضاء خفيفة بتدي لمعة للازاز
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: category.color.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          // ClipRRect عشان الـ Blur مايخرجش بره الـ Container
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: BackdropFilter(
              // هنا بيحصل تأثير الزجاج المضبب
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Stack(
                children: [
                  // الأيقونة الكبيرة في الخلفية
                  PositionedDirectional(
                    end: -15.w,
                    bottom: -15.h,
                    child: Icon(
                      category.icon,
                      size: 110.sp,
                      color: AppColors.textDark.withOpacity(
                        0.08,
                      ), // شفافية أعلى عشان ماتشوشش على التيكست
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7), // أيقونة أوضح
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Icon(
                            category.icon,
                            color: AppColors.textDark,
                            size: 28.sp,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.name,
                              style: TextStyle(
                                color: AppColors.textDark,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              '${category.subCategories.length} ${'home.categories.topics'.tr()}',
                              style: TextStyle(
                                color: AppColors.textDark.withOpacity(0.8),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
