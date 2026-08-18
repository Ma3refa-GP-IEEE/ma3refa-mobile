// ignore_for_file: deprecated_member_use
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_cubit.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_cubit.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_cubit.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_states.dart';
import 'package:ma3refa_mobile/features/quiz/data/logic/untimed_quiz_logic_mixin.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_model.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/resultscreen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/answer_options_widget.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/quiz_progress_widget.dart';

class UntimedQuizQuestionsScreen extends StatefulWidget {
  final String difficultyLevel;
  final int subCategoryId;
  final QuizModel quizModel;
  final int numberOfQuestions;
  final String quizTitle;
  final int quizTime;

  const UntimedQuizQuestionsScreen({
    super.key,
    required this.quizModel,
    required this.numberOfQuestions,
    required this.quizTitle,
    required this.quizTime,
    required this.subCategoryId,
    required this.difficultyLevel,
  });

  @override
  State<UntimedQuizQuestionsScreen> createState() =>
      _UntimedQuizQuestionsScreenState();
}

class _UntimedQuizQuestionsScreenState extends State<UntimedQuizQuestionsScreen>
    with UntimedQuizLogicMixin {
  @override
  void initState() {
    super.initState();
    initUntimedQuizLogic();
  }

  @override
  void dispose() {
    disposeUntimedQuizLogic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) {
        if (state is FinishQuizSuccessState) {
          BlocProvider.of<QuizCubit>(
            context,
          ).getQuizDetails(quizId: widget.quizModel.quizId);
        } else if (state is FetchQuizResultsSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                quizDetailsModel: state.quizDetailsModel,
                comingFromQuizScreen: true,
              ),
            ),
          );
        } else if (state is FinishQuizErrorState) {
          if (state.errorMessage.contains("already been finished")) {
            BlocProvider.of<QuizCubit>(
              context,
            ).getQuizDetails(quizId: widget.quizModel.quizId);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is FetchQuizResultsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        bool isSubmitting =
            state is FinishQuizLoadingState ||
            state is FetchQuizResultsLoadingState;
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: Colors.white.withOpacity(0.7),
                title: Text(widget.quizTitle),
                centerTitle: false,
              ),
              body: SafeArea(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    PageView.builder(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.numberOfQuestions,
                      onPageChanged: (index) {
                        setState(() {
                          currentQuestionIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final currentQuestionData =
                            widget.quizModel.questions[index];

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

                                if (currentQuestionIndex == 0)
                                  Container(
                                    padding: EdgeInsets.all(12.r),
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(color: Colors.blue),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: Colors.blue,
                                          size: 24.sp,
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Text(
                                            "This is an untimed quiz. You can take your time to answer each question.\n\nOnce you select an answer, you won't be able to change it. After answering, you'll see the explanation for the correct answer.",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ).animate().fade().slideX(),

                                Card(
                                      color: AppColors.accent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16.r),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                currentQuestionData.description,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.textDark,
                                                ),
                                              ),
                                            ),
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
                                        currentQuestionData.optionA,
                                        currentQuestionData.optionB,
                                        currentQuestionData.optionC,
                                        currentQuestionData.optionD,
                                      ],
                                      selectedAnswer:
                                          userAnswers[currentQuestionIndex]
                                              .selectedAnswer,
                                      isAnswered: isCurrentQuestionAnswered,
                                      correctAnswer:
                                          currentQuestionData.correctAnswer,
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

                                SizedBox(height: 24.h),

                                if (isCurrentQuestionAnswered) ...[
                                  Container(
                                    padding: EdgeInsets.all(16.r),
                                    decoration: BoxDecoration(
                                      color:
                                          userAnswers[currentQuestionIndex]
                                              .isCorrect
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color:
                                            userAnswers[currentQuestionIndex]
                                                .isCorrect
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userAnswers[currentQuestionIndex]
                                                  .isCorrect
                                              ? 'Correct Answer!'
                                              : 'Wrong Answer!',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                            color:
                                                userAnswers[currentQuestionIndex]
                                                    .isCorrect
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          currentQuestionData.explanation,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ).animate().fade().scale(),

                                  SizedBox(height: 24.h),

                                  CustomButton(
                                    onPressed: isSubmitting
                                        ? () {}
                                        : () {
                                            if (currentQuestionIndex ==
                                                widget.numberOfQuestions - 1) {
                                              BlocProvider.of<ProfileCubit>(
                                                context,
                                              ).fetchProfileHistory();
                                              BlocProvider.of<HomeCubit>(
                                                context,
                                              ).getAllHomeCategories();
                                              final params =
                                                  finishAndSubmitQuiz();
                                              BlocProvider.of<QuizCubit>(
                                                context,
                                              ).finishCurrentQuiz(
                                                quizId: widget.quizModel.quizId,
                                                params: params,
                                              );
                                            } else {
                                              goToNextQuestion();
                                            }
                                          },
                                    text:
                                        currentQuestionIndex ==
                                            widget.numberOfQuestions - 1
                                        ? 'finish_quiz'.tr()
                                        : 'next_question'.tr(),
                                    icon:
                                        currentQuestionIndex ==
                                            widget.numberOfQuestions - 1
                                        ? Icons.check
                                        : Icons.arrow_forward_ios,
                                  ).animate().fade().slideY(),
                                  SizedBox(height: 24.h),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    if (isWrongAnswerTriggered)
                      IgnorePointer(
                        child: Container(color: Colors.red.withOpacity(0.3))
                            .animate()
                            .fade(begin: 1.0, end: 0.0, duration: 600.ms),
                      ),
                    ConfettiWidget(
                      confettiController: confettiController,
                      blastDirection: pi / 2,
                      maxBlastForce: 5,
                      minBlastForce: 2,
                      emissionFrequency: 0.05,
                      numberOfParticles: 20,
                      gravity: 0.2,
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple,
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isSubmitting)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      },
    );
  }
}
