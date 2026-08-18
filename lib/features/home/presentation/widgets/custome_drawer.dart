// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    String avatarPath = Utils.getAvatarUrl(
      userName: widget.userName,
      gender: widget.gender,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              InkWell(
                onTap: widget.onProfileTap,
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withOpacity(0.15),
                        AppColors.primary.withOpacity(0.03),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: SizedBox(
                            width: 55.w,
                            height: 55.h,
                            child: avatarPath.startsWith('http')
                                ? Image.network(
                                    avatarPath,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.person,
                                              color: Colors.grey,
                                            ),
                                  )
                                : Image.asset(avatarPath, fit: BoxFit.cover),
                          ),
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
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Text(
                                  "View Profile",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColors.textLight,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  CupertinoIcons.chevron_right,
                                  size: 12.sp,
                                  color: AppColors.textLight,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  child: Column(
                    children: [
                      DrawerItemTile(
                        icon: getIt<AudioService>().isMuted
                            ? Icons.volume_off
                            : Icons.volume_up,
                        iconBgColor: Colors.blue.shade50,
                        iconColor: Colors.blue,
                        title: "Sound",
                        trailing: Switch.adaptive(
                          value: !getIt<AudioService>().isMuted,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            setState(() {
                              getIt<AudioService>().toggleMute();
                            });
                          },
                        ),
                      ),

                      Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Colors.grey.shade200,
                        indent: 56.w,
                      ),

                      DrawerItemTile(
                        icon: Icons.dark_mode_rounded,
                        iconBgColor: Colors.deepPurple.shade50,
                        iconColor: Colors.deepPurple,
                        title: "Dark Mode",
                        trailing: Switch.adaptive(
                          value: isDarkMode,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            _showNotAvailableDialog(context, 'Dark Mode');
                          },
                        ),
                      ),

                      Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Colors.grey.shade200,
                        indent: 56.w,
                      ),

                      DrawerItemTile(
                        icon: Icons.language_rounded,
                        iconBgColor: Colors.orange.shade50,
                        iconColor: Colors.orange,
                        title: "Language",
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.locale.languageCode.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              CupertinoIcons.chevron_right,
                              size: 14.sp,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        onTap: () {
                          _showNotAvailableDialog(context, 'Language Change');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotAvailableDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background,
          title: Text(
            title,
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Toggle $title is Not Available Yet',
            style: TextStyle(
              color: AppColors.textLight,
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
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
  }
}

class DrawerItemTile extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const DrawerItemTile({
    super.key,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20.sp),
      ),
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
      trailing: trailing,
    );
  }
}
