// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';

class CustomDrawer extends StatefulWidget {
  final String userName;
  final String gender;
  final VoidCallback onProfileTap;

  const CustomDrawer({
    super.key,
    required this.userName,
    required this.gender,
    required this.onProfileTap,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // شيلنا متغيرات الكاش والـ initState خالص
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    String avatarPath = Utils.getAvatarUrl(
      userName: widget.userName,
      gender: widget.gender,
    );

    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          SizedBox(height: 40.h),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              widget.onProfileTap();
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 60.h,
                    bottom: 20.h,
                    left: 16.w,
                    right: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: avatarPath.startsWith('http')
                              ? Image.network(
                                  avatarPath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                )
                              : Image.asset(avatarPath, fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userName,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "View Profile",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListTile(
              leading: Icon(
                getIt<AudioService>().isMuted
                    ? Icons.volume_off
                    : Icons.volume_up,
                color: AppColors.primary,
              ),
              title: Text("Sound", style: TextStyle(fontSize: 16.sp)),
              trailing: Switch(
                value: !getIt<AudioService>().isMuted,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  setState(() {
                    getIt<AudioService>().toggleMute();
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListTile(
              leading: Icon(Icons.dark_mode, color: AppColors.primary),
              title: Text("Dark Mode", style: TextStyle(fontSize: 16.sp)),
              trailing: Switch(
                value: isDarkMode,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: AppColors.background,
                        title: Text(
                          'Dark Mode',
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          'Toggle Dark Mode is Not Available Yet',
                          style: TextStyle(
                            color: AppColors.textLight,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListTile(
              leading: const Icon(Icons.language, color: AppColors.primary),
              title: Text("Language", style: TextStyle(fontSize: 16.sp)),
              trailing: Text(
                context.locale.languageCode.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.background,
                      title: Text(
                        'Language Change',
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        'Toggle Language is Not Available Yet',
                        style: TextStyle(
                          color: AppColors.textLight,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
