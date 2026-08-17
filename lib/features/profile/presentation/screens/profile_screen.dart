// ignore_for_file: use_build_context_synchronously, deprecated_member_use

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
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_cubit.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_state.dart';
import 'package:ma3refa_mobile/features/profile/presentation/screens/attempt_history.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/daily_streak_widget.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/logout_dialog_widget.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/sub_category_card_widget.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/summary_widget.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/user_card_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black12,
      useRootNavigator: true,
      builder: (dialogContext) {
        return LogOutDialogWidget(
          onConfirm: () async {
            await CacheHelper.clearData();
            Navigator.of(dialogContext).pop();

            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
              CustomSnackBar.show(
                context: context,
                title: 'Logged Out',
                message: 'You have been logged out successfully.',
                contentType: ContentType.success,
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileErrorState) {
          CustomSnackBar.show(
            context: context,
            title: 'Error',
            message: state.errorMessage,
            contentType: ContentType.failure,
          );
        }
        if (state is ProfileSuccessState) {
          CustomSnackBar.show(
            context: context,
            title: 'Success',
            message: 'Profile data refreshed successfully',
            contentType: ContentType.success,
          );
        }
        if (state is ProfileLoadingState) {
          CustomSnackBar.show(
            context: context,
            title: 'Loading',
            message: 'Refreshing profile data...',
            contentType: ContentType.help,
          );
        }
      },
      builder: (context, state) {
        bool isLoading = state is ProfileLoadingState;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: Text('my_profile'.tr()),
            titleTextStyle: TextStyle(
              color: AppColors.textDark,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout, color: AppColors.textDark),
                onPressed: () {
                  _showLogoutConfirmationDialog();
                },
              ),
            ],
          ),
          body: isLoading
              ? SafeArea(
                  child: const Center(child: CircularProgressIndicator()),
                )
              : (state is ProfileSuccessState)
              ? SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserCardWidget(
                            userName: state.profileModel.user.name,
                            userEmail: state.profileModel.user.email,
                            gender: state.profileModel.user.gender,
                          ),
                          SizedBox(height: 20.h),
                          DailyStreakWidget(
                            lastActivity: state.profileModel.lastActivity,
                            streakCount: state.profileModel.currentStreak,
                          ),
                          SizedBox(height: 20.h),
                          SummaryWidget(
                            completedQuizzes:
                                state.profileModel.allUserCompletedQuizzes,
                            totalPoints: state.profileModel.allUsertotalPoints,
                          ),
                          SizedBox(height: 5.h),
                          Divider(
                            color: AppColors.textLight.withOpacity(0.5),
                            thickness: 1,
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'quiz_history'.tr(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.replay,
                                  color: AppColors.textDark,
                                ),
                                onPressed: () {
                                  context
                                      .read<ProfileCubit>()
                                      .fetchProfileHistory();
                                },
                              ),
                            ],
                          ),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                state.profileModel.subcategoryPoints.length,
                            itemBuilder: (context, index) {
                              final subcategoryPoint =
                                  state.profileModel.subcategoryPoints[index];
                              final String subcategory =
                                  subcategoryPoint.subcategory;
                              IconData getIcon(String subcategory) {
                                return QuizData.getIconForSubcategory(
                                  subcategoryPoint.subcategory,
                                );
                              }

                              return SubCategoryCardWidget(
                                    subcategory: subcategory,
                                    subcategoryPoint:
                                        subcategoryPoint.totalPoints,
                                    icon: getIcon(subcategory),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AttemptHistoryScreen(
                                                subcategoryId: subcategoryPoint
                                                    .subcategoryId,
                                                subcategoryName: subcategory,
                                              ),
                                        ),
                                      );
                                    },
                                  )
                                  .animate()
                                  .fade(
                                    duration: 400.ms,
                                    delay: (index * 100).ms,
                                  )
                                  .slideY(
                                    begin: 0.2,
                                    duration: 400.ms,
                                    delay: (index * 100).ms,
                                    curve: Curves.easeOutQuad,
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(child: Text("No Profile Data Available")),
        );
      },
    );
  }
}
