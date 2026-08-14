// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';
import 'package:ma3refa_mobile/features/profile/data/models/history_quiz_model.dart';
import 'package:ma3refa_mobile/features/profile/data/models/pagination_model.dart';
import 'package:ma3refa_mobile/features/profile/data/models/profile_model.dart';
import 'package:ma3refa_mobile/features/profile/data/models/subcategory_quizzes_model.dart';
import 'package:ma3refa_mobile/features/profile/presentation/screens/attempt_history.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/daily_streak_widget.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/logout_dialog_widget.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/sub_category_card_widget.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/user_card_widget.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileModel profileModel;
  const ProfileScreen({super.key, required this.profileModel});

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
      builder: (context) {
        return LogOutDialogWidget(
          onConfirm: () {
            //!Perform logout action here
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserCardWidget(
                userName: widget.profileModel.user.name,
                userEmail: widget.profileModel.user.email,
                gender: widget.profileModel.user.gender,
              ),
              SizedBox(height: 20.h),
              DailyStreakWidget(streakCount: widget.profileModel.currentStreak),
              SizedBox(height: 20.h),
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
                    icon: Icon(Icons.replay, color: AppColors.textDark),
                    onPressed: () {
                      //
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.profileModel.subcategoryPoints.length,
                itemBuilder: (context, index) {
                  final subcategoryPoint =
                      widget.profileModel.subcategoryPoints[index];
                  final String subcategory = subcategoryPoint.subcategory;
                  IconData getIcon(String subcategory) {
                    return QuizData.getIconForSubcategory(
                      subcategoryPoint.subcategory,
                    );
                  }

                  return SubCategoryCardWidget(
                        subcategory: subcategory,
                        subcategoryPoint: subcategoryPoint.totalPoints,
                        icon: getIcon(subcategory),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttemptHistoryScreen(
                                subcategoryQuizzesModel:
                                    SubcategoryQuizzesModel(
                                      subcategoryId: 50,
                                      subcategory: 'Physics',
                                      totalPoints: 160,
                                      quizzes: [
                                        HistoryQuizModel(
                                          quizId: index + 1,
                                          difficulty: index % 3 == 0
                                              ? 'Easy'
                                              : index % 3 == 1
                                              ? 'Medium'
                                              : 'Hard',
                                          score: index % 3 == 0
                                              ? 3
                                              : index % 3 == 1
                                              ? 7
                                              : 14,
                                          totalQuestions: index % 3 == 0
                                              ? 5
                                              : index % 3 == 1
                                              ? 10
                                              : 15,
                                          createdAt: '2026-01-01 15:19:36',
                                        ),
                                        HistoryQuizModel(
                                          quizId: index + 1,
                                          difficulty: index % 3 == 0
                                              ? 'Easy'
                                              : index % 3 == 1
                                              ? 'Medium'
                                              : 'Hard',
                                          score: index % 3 == 0
                                              ? 3
                                              : index % 3 == 1
                                              ? 7
                                              : 14,
                                          totalQuestions: index % 3 == 0
                                              ? 5
                                              : index % 3 == 1
                                              ? 10
                                              : 15,
                                          createdAt: '2026-01-01 15:19:36',
                                        ),
                                        HistoryQuizModel(
                                          quizId: index + 1,
                                          difficulty: index % 3 == 0
                                              ? 'Easy'
                                              : index % 3 == 1
                                              ? 'Medium'
                                              : 'Hard',
                                          score: index % 3 == 0
                                              ? 3
                                              : index % 3 == 1
                                              ? 7
                                              : 14,
                                          totalQuestions: index % 3 == 0
                                              ? 5
                                              : index % 3 == 1
                                              ? 10
                                              : 15,
                                          createdAt: '2026-01-01 15:19:36',
                                        ),
                                      ],
                                      pagination: PaginationModel(
                                        currentPage: 1,
                                        perPage: 10,
                                        totalQuizzes: 5,
                                        totalPages: 1,
                                      ),
                                    ),
                              ),
                            ),
                          );
                        },
                      )
                      .animate()
                      .fade(duration: 400.ms, delay: (index * 100).ms)
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
    );
  }
}
