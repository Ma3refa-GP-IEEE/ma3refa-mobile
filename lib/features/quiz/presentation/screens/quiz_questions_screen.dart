// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/quiz/data/logic/quiz_logic.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_model.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/quiz_onboardig_screen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/answer_options_widget.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/quiz_progress_widget.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/quiz_timer_widget.dart';

class QuizQuestionsScreen extends StatefulWidget {
  final int subCategoryId;
  final QuizModel quizModel;
  final int numberOfQuestions;
  final String quizTitle;
  final int quizTime;
  const QuizQuestionsScreen({
    super.key,
    required this.quizModel,
    required this.numberOfQuestions,
    required this.quizTitle,
    required this.quizTime,
    required this.subCategoryId,
  });

  @override
  State<QuizQuestionsScreen> createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen>
    with QuizLogicMixin {
  @override
  void initState() {
    super.initState();
    initQuizLogic();
  }

  @override
  void dispose() {
    disposeQuizLogic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.7),
        title: Text(widget.quizTitle),
        centerTitle: false,
        actions: [
          QuizTimerWidget(
            durationInMinutes: 60, //durationInMinutes: widget.quizTime,
            onTimerFinished: () {
              //final result = finishAndSubmitQuiz();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizOnBoardingScreen(
                    subCategoryId: widget.subCategoryId,
                    quizModel: widget.quizModel,
                    numberOfQuestions: widget.numberOfQuestions,
                    quizTitle: widget.quizTitle,
                    quizTime: widget.quizTime,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: pageController,

        itemCount: widget.numberOfQuestions,
        onPageChanged: (index) {
          setState(() {
            currentQuestionIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              child: Column(
                key: ValueKey<int>(index),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuizProgressWidget(
                    currentQuestion: currentQuestionIndex + 1,
                    totalQuestions: widget.numberOfQuestions,
                  ),
                  SizedBox(height: 16.h),
                  Card(
                        color: AppColors.accent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.quizModel.questions[index].description,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                            ],
                          ),
                        ),
                      )
                      .animate()
                      .fade(duration: 400.ms)
                      .slideY(
                        begin: -0.2,
                        duration: 400.ms,
                        curve: Curves.easeOutBack,
                      ),
                  SizedBox(height: 16.h),
                  AnswerOptionWidget(
                        answers: [
                          widget.quizModel.questions[index].optionA,
                          widget.quizModel.questions[index].optionB,
                          widget.quizModel.questions[index].optionC,
                          widget.quizModel.questions[index].optionD,
                        ],
                        selectedAnswer:
                            userAnswers[currentQuestionIndex].selectedAnswer,
                        onOptionSelected: (selectedOption) {
                          handleAnswerSelection(
                            selectedAnswerOption: selectedOption,
                          );
                        },
                      )
                      .animate(delay: 200.ms)
                      .fade(duration: 400.ms)
                      .slideY(
                        begin: 0.1,
                        duration: 400.ms,
                        curve: Curves.easeOut,
                      ),
                  SizedBox(height: 16.h),
                  currentQuestionIndex == widget.numberOfQuestions - 1
                      ? CustomButton(
                          onPressed: () {
                            showSubmitConfirmationDialog();
                          },
                          text: 'finish_quiz'.tr(),
                          icon: Icons.check,
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
