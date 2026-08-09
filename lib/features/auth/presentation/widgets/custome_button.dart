import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: 320.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 22.sp,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10.w),
            icon != null
                ? Icon(
                    icon,
                    color: AppColors.white,
                    size: 22.sp,
                    fontWeight: FontWeight.bold,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
