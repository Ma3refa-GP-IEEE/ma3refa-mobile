import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/difficulty_selector.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/number_of_question_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/time_selection_widget.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_cubit.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_states.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_setup_params.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/timed_quiz_questions_screen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/untimed_quiz_questions_screen.dart';

class QuizSetupScreen extends StatefulWidget {
  //   {
  //   "subcategory_id": 8,
  //   "difficulty": 2,
  //   "number_of_questions": 10
  // }
  final int subCategoryId;
  final String quizTitle;
  const QuizSetupScreen({
    super.key,
    required this.subCategoryId,
    required this.quizTitle,
  });

  @override
  State<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  String selectedDifficulty = 'Medium';
  int selectedNumberOfQuestions = 10;
  int selectedMinutes = 10;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) {
        if (state is GenerateQuizSuccessState) {
          if (selectedMinutes == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UntimedQuizQuestionsScreen(
                  quizModel: state.quiz,
                  numberOfQuestions: selectedNumberOfQuestions,
                  quizTitle: widget.quizTitle,
                  quizTime: 0,
                  subCategoryId: widget.subCategoryId,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TimedQuizQuestionsScreen(
                  quizModel: state.quiz,
                  numberOfQuestions: selectedNumberOfQuestions,
                  quizTitle: widget.quizTitle,
                  quizTime: selectedMinutes,
                  subCategoryId: widget.subCategoryId,
                ),
              ),
            );
          }
        } else if (state is GenerateQuizErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        bool isLoading = state is GenerateQuizLoadingState;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                    [
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
                            onPressed: isLoading
                                ? () {}
                                : () {
                                    getIt<AudioService>().playAssetSound(
                                      'sounds/click_at_quiz_setup.mp3',
                                    );
                                    BlocProvider.of<QuizCubit>(
                                      context,
                                    ).generateNewQuiz(
                                      params: QuizSetupParams(
                                        difficulty: selectedDifficulty,
                                        numberOfQuestions:
                                            selectedNumberOfQuestions,
                                        subcategoryId: widget.subCategoryId,
                                      ),
                                    );
                                  },
                            text: isLoading
                                ? 'Loading...'.tr()
                                : 'home.quizSetup.startQuiz'.tr(),
                            icon: isLoading
                                ? Icons.hourglass_empty
                                : Icons.arrow_forward,
                          ),
                        ]
                        .animate(interval: 100.ms)
                        .fade(duration: 400.ms)
                        .slideY(
                          begin: 0.1,
                          duration: 400.ms,
                          curve: Curves.easeOutQuad,
                        ),
              ),
            ),
          ),
        );
      },
    );
  }

  Align _buildCustomText({
    required String text,
    required double fontSize,
    required Color color,
  }) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
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
