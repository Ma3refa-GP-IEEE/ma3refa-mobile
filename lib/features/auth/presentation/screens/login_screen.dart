// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/auth/presentation/screens/signup_screen.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custom_rich_text.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_textFormField.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/logo_card_widget.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/welcom_massege_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(10.r),
        child: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoCardWidget(width: 96.w, height: 96.h),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(15.r),
                    width: MediaQuery.of(context).size.width * 0.83.w,
                    //height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WelcomeMassege(
                            title: 'welcome'.tr(),
                            subtitle: 'welcome_subtitle'.tr(),
                          ),
                          SizedBox(height: 22.h),
                          CustomTextFormField(
                            labelText: 'email_address'.tr(),
                            hintText: 'student@example.com',
                            controller: emailController,
                            validator: AppValidators.validateEmailInLogin,
                            prefixIcon: Icons.mail_outline,
                          ),
                          SizedBox(height: 25.h),
                          CustomTextFormField(
                            labelText: 'password'.tr(),
                            hintText: '••••••••',
                            controller: passwordController,
                            validator: AppValidators.validatePassword,
                            prefixIcon: Icons.lock_outline,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Handle forgot password logic here
                                },
                                child: Text(
                                  'forgot_password'.tr(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                //TODO: Implement logic here
                              }
                            },
                            text: 'login'.tr(),
                            icon: Icons.arrow_forward,
                          ),
                          SizedBox(height: 15.h),
                          CustomRichText(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            textOne: 'dont_have_account'.tr(),
                            textTwo: 'sign_up'.tr(),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
