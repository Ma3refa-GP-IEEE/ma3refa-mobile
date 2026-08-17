import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';

class SubmitDialogWidget extends StatefulWidget {
  final VoidCallback onSubmit;
  const SubmitDialogWidget({super.key, required this.onSubmit});

  @override
  State<SubmitDialogWidget> createState() => _SubmitDialogWidgetState();
}

class _SubmitDialogWidgetState extends State<SubmitDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F7FC),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_outline_rounded,
                      color: const Color(0xFF1B4D6A),
                      size: 36.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Text(
                    'submit_quiz'.tr(),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B4D6A),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Text(
                    'submit_quiz_confirm'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 28.h),

                  Column(
                    children: [
                      CustomButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'review_answers'.tr(),
                        buttonColor: Colors.white,
                        textColor: AppColors.textDark,
                      ),

                      SizedBox(height: 12.h),
                      CustomButton(
                        onPressed: widget.onSubmit,
                        text: 'yes_submit'.tr(),
                        icon: Icons.check,
                        textColor: Colors.white,
                        buttonColor: Colors.greenAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fade(duration: 300.ms)
        .scale(
          begin: const Offset(0.8, 0.8),
          curve: Curves.easeOutBack,
          duration: 350.ms,
        );
  }
}
