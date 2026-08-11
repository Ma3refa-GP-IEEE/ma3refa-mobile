import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_textFormField.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/difficulty_selector.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/number_of_question_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/time_selection_widget.dart';

class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({super.key});

  @override
  State<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  TextEditingController ageController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String selectedDifficulty = 'Medium';
  int selectedNumberOfQuestions = 10;
  int selectedMinutes = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text('home.quizSetup.title'.tr()),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        leading: IconButton(
          color: AppColors.background,
          icon: Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildCustomText(
                  text: 'home.quizSetup.selectDifficulty'.tr(),
                  fontSize: 18.sp,
                  color: AppColors.textDark,
                ),
                SizedBox(height: 10.h),
                DifficultySelector(
                  onDifficultySelected: (difficulty) {
                    selectedDifficulty = difficulty;
                  },
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildCustomText(
                      text: 'home.quizSetup.targetAge'.tr(),
                      fontSize: 18.sp,
                      color: AppColors.textDark,
                    ),
                    SizedBox(width: 5.w),
                    _buildCustomText(
                      text: 'home.quizSetup.targetAgeOptional'.tr(),
                      fontSize: 16.sp,
                      color: AppColors.textLight,
                    ),
                  ],
                ),
                _buildCustomText(
                  text: 'home.quizSetup.ageDescription'.tr(),
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
                CustomTextFormField(
                  isLabelNeded: false,
                  controller: ageController,
                  labelText: '',
                  hintText: 'home.quizSetup.ageHint'.tr(),
                  validator: (String? p1) {
                    if (p1 == null || p1.isEmpty) {
                      return null;
                    }
                    final age = int.tryParse(p1);
                    if (age == null || age < 0) {
                      return 'home.quizSetup.invalidAge'.tr();
                    }
                    return null;
                  },
                  prefixIcon: null,
                ),
                SizedBox(height: 20.h),
                NumberOfQuestionWidget(
                  onNumberOfQuestionsSelected: (int p1) {
                    selectedNumberOfQuestions = p1;
                  },
                ),
                SizedBox(height: 20.h),
                _buildCustomText(
                  text: 'home.quizSetup.timeDuration'.tr(),
                  fontSize: 18.sp,
                  color: AppColors.textDark,
                ),
                SizedBox(height: 10.h),
                TimeSelectionCard(
                  onTimeSelected: (int p1) {
                    selectedMinutes = p1;
                  },
                ),
                SizedBox(height: 100.h),
                CustomButton(
                  onPressed: () {},
                  text: 'home.quizSetup.startQuiz'.tr(),
                  icon: Icons.arrow_forward,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _buildCustomText({
    required String text,
    required double fontSize,
    required Color color,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        maxLines: 2,
        textAlign: TextAlign.center,
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
