// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_model.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/quiz_questions_screen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/loading_card_widget.dart';

class QuizOnBoardingScreen extends StatelessWidget {
  final int subCategoryId;
  final QuizModel quizModel;
  final int numberOfQuestions;
  final String quizTitle;
  final int quizTime;
  const QuizOnBoardingScreen({
    super.key,
    required this.quizModel,
    required this.numberOfQuestions,
    required this.quizTitle,
    required this.quizTime,
    required this.subCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Almost Ready! 🚀',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                LoadingCardWidget(width: 256.w, height: 288.h),
                SizedBox(height: 25.h),

                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Quick Tips for Success',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.textLight,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                _buildTipCard(
                  tip:
                      'Read the questions carefully and take your time to answer.',
                  icon: Icons.lightbulb_outline,
                ),
                _buildTipCard(
                  tip: 'Keep an eye on the countdown timer.',
                  icon: Icons.timer,
                ),
                _buildTipCard(
                  tip: 'Try your best, and don\'t panic!',
                  icon: Icons.sentiment_satisfied_alt,
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizQuestionsScreen(
                          quizModel: quizModel,
                          numberOfQuestions: numberOfQuestions,
                          quizTitle: quizTitle,
                          quizTime: quizTime,
                          subCategoryId: subCategoryId,
                        ),
                      ),
                    );
                  },
                  text: 'get_started'.tr(),
                  icon: Icons.arrow_forward,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card _buildTipCard({required String tip, required IconData icon}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: ListTile(
          leading: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          title: Text(
            tip,
            style: TextStyle(fontSize: 16.sp, color: AppColors.textDark),
          ),
        ),
      ),
    );
  }
}
