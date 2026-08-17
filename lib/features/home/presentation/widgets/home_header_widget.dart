// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';

class HomeHeaderWidget extends StatelessWidget {
  final String userName;
  final String gender;

  const HomeHeaderWidget({
    super.key,
    required this.userName,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    String avatarPath = Utils.getAvatarUrl(userName: userName, gender: gender);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              padding: EdgeInsets.all(2.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  color: Colors.white,
                  child: avatarPath.startsWith('http')
                      ? Image.network(
                          avatarPath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 30.sp,
                          ),
                        )
                      : Image.asset(avatarPath, fit: BoxFit.cover),
                ),
              ),
            ),
          ),

          SizedBox(width: 30.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'hello_header'.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'header_subtitle'.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.textLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
