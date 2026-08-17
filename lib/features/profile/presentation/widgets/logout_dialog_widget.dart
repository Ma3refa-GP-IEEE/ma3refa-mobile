import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';

class LogOutDialogWidget extends StatefulWidget {
  final VoidCallback onConfirm;
  const LogOutDialogWidget({super.key, required this.onConfirm});

  @override
  State<LogOutDialogWidget> createState() => _LogOutDialogWidgetState();
}

class _LogOutDialogWidgetState extends State<LogOutDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child:
          Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 28.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBEBE7),
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.sentiment_dissatisfied_rounded,
                          color: const Color(0xFF133F53),
                          size: 40.sp,
                        ).animate(delay: 200.ms).shake(hz: 3, duration: 400.ms),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'logging_out'.tr(),
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF133F53),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'logout_confirm'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF4A6572),
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 28.h),

                      Column(
                        children: [
                          CustomButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            text: 'stay_connected'.tr(),
                            textColor: AppColors.textDark,
                            buttonColor: Colors.white,
                          ),

                          SizedBox(height: 6.w),
                          CustomButton(
                            onPressed: () {
                              widget.onConfirm();
                            },
                            text: 'yes_logout'.tr(),
                            textColor: Colors.white,
                            buttonColor: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              .animate()
              .fade(duration: 300.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                curve: Curves.easeOutBack,
                duration: 350.ms,
              ),
    );
  }
}
