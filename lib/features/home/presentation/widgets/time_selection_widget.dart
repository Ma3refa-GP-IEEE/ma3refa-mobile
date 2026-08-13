import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class TimeSelectionCard extends StatefulWidget {
  final Function(int) onTimeSelected;
  const TimeSelectionCard({super.key, required this.onTimeSelected});

  @override
  State<TimeSelectionCard> createState() => _TimeSelectionCardState();
}

class _TimeSelectionCardState extends State<TimeSelectionCard> {
  int selectedMinutes = 10;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffBEE9E8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: ListTile(
          title: Text(
            '$selectedMinutes ${'home.quizSetup.minutes'.tr()}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          leading: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.timer, color: AppColors.textDark, size: 28.sp),
          ),
          trailing: IconButton(
            onPressed: () => _showTimePicker(context),
            icon: const Icon(Icons.edit, color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      builder: (context) {
        int tempMinutes = selectedMinutes;
        return Container(
          height: 350.h,
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'home.quizSetup.selectDuration'.tr(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 50.h,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedMinutes - 1,
                  ),
                  onSelectedItemChanged: (index) {
                    tempMinutes = index + 1;
                  },
                  children: List.generate(60, (index) {
                    return Center(
                      child: Text(
                        '${index + 1} ${'home.quizSetup.minutes'.tr()}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.textDark,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedMinutes = tempMinutes;
                    });
                    widget.onTimeSelected(selectedMinutes);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'home.quizSetup.confirm'.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
