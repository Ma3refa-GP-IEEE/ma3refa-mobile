import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/custom_snackbar.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:ma3refa_mobile/features/auth/cubit/auth_states.dart';
import 'package:ma3refa_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custom_rich_text.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_textFormField.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/gender_selector_widget.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/welcom_massege_widget.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_cubit.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_cubit.dart';

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
  final GlobalKey<CustomButtonState> _btnKey = GlobalKey<CustomButtonState>();
  String userGender = 'male';

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h),
                    Container(
                          padding: EdgeInsets.all(12.r),
                          width: MediaQuery.of(context).size.width * 0.9.w,
                          //height: 200.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...[
                                      WelcomeMassege(
                                        title: 'sign_up_title'.tr(),
                                        subtitle: 'sign_up_subtitle'.tr(),
                                      ),
                                      SizedBox(height: 22.h),

                                      CustomTextFormField(
                                        labelText: 'first_name'.tr(),
                                        hintText: 'first_name_hint'.tr(),
                                        controller: firstNameController,
                                        validator:
                                            AppValidators.validateFirstName,
                                        prefixIcon: Icons.person_outline,
                                      ),
                                      SizedBox(height: 15.h),
                                      CustomTextFormField(
                                        labelText: 'last_name'.tr(),
                                        hintText: 'last_name_hint'.tr(),
                                        controller: lastNameController,
                                        validator:
                                            AppValidators.validateLastName,
                                        prefixIcon: Icons.person_outline,
                                      ),
                                      SizedBox(height: 15.h),
                                      CustomTextFormField(
                                        labelText: 'email_address'.tr(),
                                        hintText: 'email_hint'.tr(),
                                        controller: emailController,
                                        validator:
                                            AppValidators.validateEmailInSignUp,
                                        prefixIcon: Icons.lock_outline,
                                      ),
                                      GenderSelector(
                                        onGenderSelected: (gender) {
                                          userGender = gender.toLowerCase();
                                        },
                                      ),
                                      SizedBox(height: 15.h),
                                      CustomTextFormField(
                                        labelText: 'age'.tr(),
                                        hintText: 'age_hint'.tr(),
                                        controller: ageController,
                                        validator: AppValidators.validateAge,
                                        keyboardType: TextInputType.number,
                                        prefixIcon:
                                            Icons.calendar_today_outlined,
                                      ),
                                      SizedBox(height: 15.h),
                                      CustomTextFormField(
                                        labelText: 'password'.tr(),
                                        hintText: '••••••••',
                                        controller: passwordController,
                                        validator:
                                            AppValidators.validatePassword,
                                        prefixIcon: Icons.lock_outline,
                                      ),
                                      SizedBox(height: 15.h),
                                      CustomTextFormField(
                                        labelText: 'confirm_password'.tr(),
                                        hintText: '••••••••',
                                        controller: confirmPasswordController,
                                        validator: (value) =>
                                            AppValidators.validateConfirmPassword(
                                              value,
                                              passwordController.text,
                                            ),
                                        prefixIcon: Icons.lock_outline,
                                      ),
                                      SizedBox(height: 23.h),
                                      BlocConsumer<AuthCubit, AuthStates>(
                                        listener: (context, state) {
                                          if (state is AuthErrorState) {
                                            getIt<AudioService>().playAssetSound(
                                              'sounds/failed_login_or_signup_sound.mp3',
                                            );
                                            CustomSnackBar.show(
                                              context: context,
                                              title: 'Error',
                                              message: state.message,
                                              contentType: ContentType.failure,
                                            );
                                          } else if (state
                                              is AuthSuccessState) {
                                            final String firstName = state
                                                .user
                                                .name
                                                .split(' ')
                                                .first;
                                            final String lastName =
                                                state.user.name
                                                        .split(' ')
                                                        .length >
                                                    1
                                                ? state.user.name
                                                      .split(' ')
                                                      .sublist(1)
                                                      .join(' ')
                                                : '';
                                            CacheHelper.saveUserData(
                                              firstName: firstName,
                                              lastName: lastName,
                                              email: state.user.email,
                                              userAge: state.user.age,
                                              gender: state.user.gender,
                                            );
                                            CustomSnackBar.show(
                                              context: context,
                                              title: 'Success',
                                              message: 'registration_success'
                                                  .tr(),
                                              contentType: ContentType.success,
                                            );
                                            BlocProvider.of<HomeCubit>(
                                              context,
                                            ).getAllHomeCategories();
                                            BlocProvider.of<ProfileCubit>(
                                              context,
                                            ).fetchProfileHistory();
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(
                                                      gender: state.user.gender,
                                                      userName: state.user.name,
                                                    ),
                                              ),
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          return CustomButton(
                                            key: _btnKey,
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();

                                              if (!formKey.currentState!
                                                  .validate()) {
                                                _btnKey.currentState?.shake();
                                                getIt<AudioService>()
                                                    .playAssetSound(
                                                      'sounds/failed_login_or_signup_sound.mp3',
                                                    );
                                              } else {
                                                BlocProvider.of<AuthCubit>(
                                                  context,
                                                ).register(
                                                  nameController:
                                                      '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
                                                  emailController:
                                                      emailController.text
                                                          .trim(),
                                                  passwordController:
                                                      passwordController.text,
                                                  ageController:
                                                      int.tryParse(
                                                        ageController.text
                                                            .trim(),
                                                      ) ??
                                                      22,
                                                  genderController: userGender,
                                                  passwordConfirmationController:
                                                      confirmPasswordController
                                                          .text,
                                                );
                                              }
                                            },
                                            text: 'register'.tr(),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 15.h),
                                      CustomRichText(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen(),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                        textOne: 'already_have_account'.tr(),
                                        textTwo: 'login'.tr(),
                                      ),
                                    ]
                                    .animate(interval: 100.ms)
                                    .fade(duration: 300.ms)
                                    .slideY(
                                      begin: 0.2,
                                      duration: 300.ms,
                                      curve: Curves.easeOut,
                                    ),
                                SizedBox(height: 15.h),
                              ],
                            ),
                          ),
                        )
                        .animate()
                        .fade(duration: 300.ms)
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          duration: 300.ms,
                          curve: Curves.easeOutBack,
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
