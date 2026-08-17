import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class CustomButton extends StatefulWidget {
  final Color? textColor;
  final Color? buttonColor;
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.textColor,
    this.buttonColor,
  });

  @override
  State<CustomButton> createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  AnimationController? _shakeController;

  void shake() {
    _shakeController?.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    bool currentIsDialog = false;
    widget.textColor != null ? currentIsDialog = true : currentIsDialog = false;
    return SizedBox(
          height: 60.h,
          width: 320.w,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: currentIsDialog
                  ? widget.buttonColor
                  : AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            onPressed: widget.onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: currentIsDialog ? widget.textColor : AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.w),
                widget.icon != null
                    ? Icon(widget.icon, color: AppColors.white, size: 22.sp)
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        )
        .animate()
        .fade(duration: 400.ms)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack)
        .animate(
          autoPlay: false,
          onInit: (controller) => _shakeController = controller,
        )
        .shake(hz: 4, curve: Curves.easeInOutCubic, duration: 300.ms);
  }
}
