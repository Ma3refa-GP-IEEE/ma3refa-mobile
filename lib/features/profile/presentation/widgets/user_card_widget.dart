// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      color: Color(0xffA8DADC),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.r, vertical: 10.r),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.only(right: 10.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blueAccent.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: Container(
                width: 48.w,
                height: 48.h,
                color: Colors.grey.shade100,
                child: SvgPicture.network(
                  Utils.getAvatarUrl(userName: userName, gender: gender),
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) => Center(
                    child: SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            userName,
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            userEmail,
            style: TextStyle(color: AppColors.textLight, fontSize: 16.sp),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Handle edit profile action
              },
            ),
          ),
        ),
      ),
    );
  }
}
