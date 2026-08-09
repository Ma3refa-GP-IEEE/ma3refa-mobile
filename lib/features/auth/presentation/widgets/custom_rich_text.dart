import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class CustomRichText extends StatefulWidget {
  final VoidCallback onTap;
  final String textOne;
  final String textTwo;
  const CustomRichText({
    super.key,
    required this.onTap,
    required this.textOne,
    required this.textTwo,
  });

  @override
  State<CustomRichText> createState() => _CustomRichTextState();
}

class _CustomRichTextState extends State<CustomRichText> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: widget.textOne,
        style: TextStyle(fontSize: 16.sp, color: AppColors.textLight),
        children: [
          WidgetSpan(child: SizedBox(width: 7.w)),
          TextSpan(
            text: widget.textTwo,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                widget.onTap();
              },
          ),
        ],
      ),
    );
  }
}
