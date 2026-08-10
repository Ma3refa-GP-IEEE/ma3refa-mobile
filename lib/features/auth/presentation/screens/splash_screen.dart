import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:ma3refa_mobile/features/auth/presentation/screens/on_boarding_screen.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/logo_card_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startSplashLogic();
  }

  Future<void> _startSplashLogic() async {
    FlutterSplashScreen.hide();
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    bool isOnBoardingVisited = await CacheHelper.getOnBoarding() ?? false;
    String? token = await CacheHelper.getToken();

    Widget nextScreen;

    if (isOnBoardingVisited) {
      if (token != null && token.isNotEmpty) {
        nextScreen = const HomeScreen();
      } else {
        nextScreen = const LoginScreen();
      }
    } else {
      nextScreen = const OnBoardingScreen();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(15).r,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 200.w 200.h
              LogoCardWidget(width: 200.w, height: 200.h),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'app_name'.tr(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'app_name_subtitle'.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
