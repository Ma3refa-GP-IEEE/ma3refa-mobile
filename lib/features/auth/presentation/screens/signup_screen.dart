import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custom_rich_text.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_textFormField.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/gender_selector_widget.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/welcom_massege_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String userGender = 'Male';

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
                            title: 'sign_up_title'.tr(),
                            subtitle: 'sign_up_subtitle'.tr(),
                          ),
                          SizedBox(height: 22.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: 'first_name'.tr(),
                                  hintText: 'Mahmoud',
                                  controller: firstNameController,
                                  validator: AppValidators.validateFirstName,
                                  prefixIcon: Icons.person_outline,
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                child: CustomTextFormField(
                                  labelText: 'last_name'.tr(),
                                  hintText: 'Abdelghani',
                                  controller: lastNameController,
                                  validator: AppValidators.validateLastName,
                                  prefixIcon: Icons.person_outline,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          CustomTextFormField(
                            labelText: 'email_address'.tr(),
                            hintText: 'student@example.com',
                            controller: emailController,
                            validator: AppValidators.validateEmailInSignUp,
                            prefixIcon: Icons.lock_outline,
                          ),
                          GenderSelector(
                            onGenderSelected: (gender) {
                              userGender = gender;
                            },
                          ),
                          SizedBox(height: 15.h),
                          CustomTextFormField(
                            labelText: 'password'.tr(),
                            hintText: '••••••••',
                            controller: passwordController,
                            validator: AppValidators.validatePassword,
                            prefixIcon: Icons.lock_outline,
                          ),
                          SizedBox(height: 15.h),
                          CustomTextFormField(
                            labelText: 'confirm_password'.tr(),
                            hintText: '••••••••',
                            controller: confirmPasswordController,
                            validator: AppValidators.validateConfirmPassword(
                              passwordController.text,
                            ),
                            prefixIcon: Icons.lock_outline,
                          ),
                          SizedBox(height: 23.h),
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                //TODO: Implement logic here
                              }
                            },
                            text: 'register'.tr(),
                          ),
                          SizedBox(height: 15.h),
                          CustomRichText(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            textOne: 'already_have_account'.tr(),
                            textTwo: 'login'.tr(),
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
