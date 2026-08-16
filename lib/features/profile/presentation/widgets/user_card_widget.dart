// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';

class UserCardWidget extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String gender;

  const UserCardWidget({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    String avatarPath = Utils.getAvatarUrl(userName: userName, gender: gender);
    return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          color: const Color(0xffA8DADC),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blueAccent.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Container(
                          width: 56.w,
                          height: 56.h,
                          color: Colors.white,
                          child: avatarPath.startsWith('http')
                              ? Image.network(
                                  avatarPath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                        size: 30.sp,
                                      ),
                                )
                              : Image.asset(avatarPath, fit: BoxFit.cover),
                        ),
                      ),
                    )
                    .animate(delay: 200.ms)
                    .scale(duration: 400.ms, curve: Curves.easeOutBack),

                SizedBox(width: 16.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        userEmail,
                        style: TextStyle(
                          color: AppColors.textLight,
                          fontSize: 14.sp,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.textDark),
                    onPressed: () {
                      // Handle edit profile action
                    },
                  ),
                ).animate(delay: 600.ms).shake(hz: 3, duration: 400.ms),
              ],
            ),
          ),
        )
        .animate()
        .fade(duration: 400.ms)
        .slideY(begin: -0.2, curve: Curves.easeOutBack, duration: 400.ms);
  }
}
