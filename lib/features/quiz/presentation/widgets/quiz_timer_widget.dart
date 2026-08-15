// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';

class QuizTimerWidget extends StatefulWidget {
  final int durationInMinutes;
  final VoidCallback onTimerFinished;

  const QuizTimerWidget({
    super.key,
    required this.durationInMinutes,
    required this.onTimerFinished,
  });

  @override
  State<QuizTimerWidget> createState() => _QuizTimerWidgetState();
}

class _QuizTimerWidgetState extends State<QuizTimerWidget> {
  Timer? _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationInMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        getIt<AudioService>().playAssetSound('sounds/time_out_sound.wav');
        _showTimeUpDialog();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSecs = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSecs.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      useRootNavigator: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child:
              Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 28.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.r),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFEAEA),
                              shape: BoxShape.circle,
                            ),
                            child:
                                Icon(
                                      Icons.access_alarm_rounded,
                                      color: const Color(0xFF990000),
                                      size: 36.sp,
                                    )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(reverse: true),
                                    )
                                    .scale(
                                      begin: const Offset(1.0, 1.0),
                                      end: const Offset(1.15, 1.15),
                                      duration: 600.ms,
                                    ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'time_is_up'.tr(),
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1B4D6A),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'quiz_time_ended'.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey[600],
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 28.h),
                          CustomButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              widget.onTimerFinished();
                            },
                            text: 'view_results'.tr(),
                            icon: Icons.arrow_forward,
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
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 100.w,
      margin: EdgeInsetsDirectional.only(end: 16.w),
      decoration: BoxDecoration(
        color: AppColors.cardSurface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer, color: AppColors.textDark, size: 20.sp),
            SizedBox(width: 4.w),
            Text(
              _formatTime(_remainingSeconds),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
