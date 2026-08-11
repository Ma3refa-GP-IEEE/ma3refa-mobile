// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/logo_card_widget.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LogoCardWidget(width: 60.w, height: 60.h),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'hello_header'.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: 200.w,
                child: Text(
                  'header_subtitle'.tr(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.textLight),
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
