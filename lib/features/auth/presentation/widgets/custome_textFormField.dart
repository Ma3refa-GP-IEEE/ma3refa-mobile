// ignore_for_file: must_be_immutable, file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  bool? isPasswordField;
  final TextInputType? keyboardType;
  final bool isLabelNeded;
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.validator,
    required this.prefixIcon,
    this.isLabelNeded = true,
    this.keyboardType,
    this.isPasswordField = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isLabelNeded
            ? Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  widget.labelText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              )
            : SizedBox.shrink(),
        SizedBox(height: 8.h),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,

          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            suffixIcon: widget.isPasswordField!
                ? IconButton(
                    icon: Icon(
                      widget.isPasswordField!
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.blueGrey,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.isPasswordField = !widget.isPasswordField!;
                      });
                    },
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.blueGrey.withOpacity(0.6),
              fontSize: 14.sp,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: Colors.blueGrey)
                : null,
            filled: true,
            fillColor: AppColors.accent,
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: Color(0xFFC7E4E7), width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(
                color: Color(0xFF8DBFBE),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
