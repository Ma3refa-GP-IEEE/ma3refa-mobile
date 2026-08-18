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

    double avatarRadius = 38.r;

    return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: avatarRadius),
              padding: EdgeInsets.only(
                left: (avatarRadius * 2) + 24.w,
                top: 24.h,
                bottom: 24.h,
                right: 16.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.65),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    userEmail,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14.sp,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            Positioned(
              top: 0,
              left: 16.w,
              child:
                  Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.background,
                                width: 4.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Container(
                                width: avatarRadius * 2.5,
                                height: avatarRadius * 2.5,
                                color: Colors.white,
                                child: avatarPath.startsWith('http')
                                    ? Image.network(
                                        avatarPath,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.grey,
                                                  size: 30.sp,
                                                ),
                                      )
                                    : Image.asset(
                                        avatarPath,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: -4.h,
                            right: -4.w,
                            child:
                                GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(8.r),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.primary,
                                            width: 1.5.w,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.15,
                                              ),
                                              blurRadius: 6,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.edit_rounded,
                                          color: AppColors.primary,
                                          size: 16.sp,
                                        ),
                                      ),
                                    )
                                    .animate(delay: 600.ms)
                                    .shake(hz: 3, duration: 400.ms),
                          ),
                        ],
                      )
                      .animate(delay: 200.ms)
                      .scale(duration: 400.ms, curve: Curves.easeOutBack),
            ),
          ],
        )
        .animate()
        .fade(duration: 400.ms)
        .slideY(begin: -0.2, curve: Curves.easeOutBack, duration: 400.ms);
  }
}
