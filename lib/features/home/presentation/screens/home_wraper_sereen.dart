// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/custom_snackbar.dart';
import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/custome_drawer.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_cubit.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_state.dart';
import 'package:ma3refa_mobile/features/profile/presentation/screens/profile_screen.dart';

class HomeWrapper extends StatefulWidget {
  final String? userName;
  final String? gender;

  const HomeWrapper({super.key, this.userName, this.gender});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  String currentUserName = "Guest";
  String currentGender = "male";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final UserModel userData = await CacheHelper.getUserData();
    setState(() {
      currentUserName = widget.userName ?? userData.name;
      currentGender = widget.gender ?? userData.gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        if (zoomDrawerController.isOpen?.call() ?? false) {
          zoomDrawerController.close?.call();
          return;
        }

        final bool? shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => BackdropFilter(
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
                              child:
                                  Icon(
                                        Icons.sentiment_dissatisfied_rounded,
                                        color: const Color(0xFF133F53),
                                        size: 40.sp,
                                      )
                                      .animate(delay: 200.ms)
                                      .shake(hz: 3, duration: 400.ms),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Leaving so soon? 😢",
                              style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF133F53),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "Are you sure you want to exit the app?",
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
                                  buttonColor: Colors.green.shade600,
                                ),

                                SizedBox(height: 6.w),
                                CustomButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  text: "Yes, Exit",
                                  textColor: Colors.black,
                                  buttonColor: Colors.grey.shade300,
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
          ),
        );

        if (shouldExit == true) {
          SystemNavigator.pop();
        }
      },
      child: ZoomDrawer(
        closeCurve: Curves.easeInOut,
        mainScreenScale: 0.8,
        controller: zoomDrawerController,
        mainScreenTapClose: true,
        menuScreen: CustomDrawer(
          userName: currentUserName,
          gender: currentGender,
          onProfileTap: () {
            zoomDrawerController.close?.call();
            Future.delayed(const Duration(milliseconds: 300), () {
              if (!context.mounted) return;
              final profileState = BlocProvider.of<ProfileCubit>(context).state;
              if (profileState is ProfileSuccessState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              } else {
                BlocProvider.of<ProfileCubit>(context).fetchProfileHistory();
                CustomSnackBar.show(
                  context: context,
                  title: 'Error',
                  message: 'Failed to load profile. Please try again.',
                  contentType: ContentType.failure,
                );
              }
            });
          },
        ),

        mainScreen: HomeScreen(
          userName: currentUserName,
          gender: currentGender,
        ),

        borderRadius: 24.r,
        showShadow: true,
        angle: -10.0,
        drawerShadowsBackgroundColor: Colors.grey.shade300,
        slideWidth: MediaQuery.of(context).size.width * 0.80,
        menuBackgroundColor: AppColors.secondaryBackground,
      ),
    );
  }
}
