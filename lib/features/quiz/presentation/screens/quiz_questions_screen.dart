// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/result_params.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/quiz_onboardig_screen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/resultscreen.dart';
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

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen> {
  late List<Answer> _userAnswers;
  late PageController _pageController;
  int _currentQuestionIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _userAnswers = List.generate(widget.numberOfQuestions, (index) {
      //final question = widget.quizModel.questions[index];
      return Answer(
        questionId: index + 1,
        selectedAnswer: 'skipped',
        isCorrect: false,
      );
    });
  }

  void _handleAnswerSelection({required String selectedAnswerOption}) {
    final currentQuestion = widget.quizModel.questions[_currentQuestionIndex];
    bool isCorrectAnswer =
        (selectedAnswerOption == currentQuestion.correctAnswer);

    setState(() {
      _userAnswers[_currentQuestionIndex] = Answer(
        questionId: currentQuestion.id,
        selectedAnswer: selectedAnswerOption,
        isCorrect: isCorrectAnswer,
      );
    });

    if (_currentQuestionIndex < widget.numberOfQuestions - 1) {
      Future.delayed(const Duration(milliseconds: 400), () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    }
  }

  ResultParams _finishAndSubmitQuiz() {
    int finalScore = _userAnswers.where((ans) => ans.isCorrect).length;
    int subCatId = widget.subCategoryId;
    ResultParams result = ResultParams(
      score: finalScore,
      answers: _userAnswers,
      subcategoryId: subCatId,
    );
    //BlocProvider.of<QuizCubit>(context).finishCurrentQuiz(quizId: widget.quizId, resultParams: result);
    return result;
  }

  void _showSubmitConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      useRootNavigator: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F7FC),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_outline_rounded,
                      color: const Color(0xFF1B4D6A),
                      size: 36.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Text(
                    'Submit Your Quiz?',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B4D6A),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Text(
                    'Are you sure you want to finish and submit your answers now? You won\'t be able to change them.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 28.h),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48.h,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFF1B4D6A),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Review Answers',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1B4D6A),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: SizedBox(
                          height: 48.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1B4D6A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();

                              final result = _finishAndSubmitQuiz();
                              //BlocProvider.of<QuizCubit>(context).getQuizDetails(quizId: widget.quizId);
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ResultScreen(
                              //       quizDetailsModel: quizDetails,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Text(
                              'Yes, Submit',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
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
              final result = _finishAndSubmitQuiz();
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
        controller: _pageController,
        itemCount: widget.numberOfQuestions,
        onPageChanged: (index) {
          setState(() {
            _currentQuestionIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuizProgressWidget(
                    //ToDO: Add Animation to the progress bar
                    currentQuestion: _currentQuestionIndex + 1,
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
                        _userAnswers[_currentQuestionIndex].selectedAnswer,
                    onOptionSelected: (selectedOption) {
                      _handleAnswerSelection(
                        selectedAnswerOption: selectedOption,
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  _currentQuestionIndex == widget.numberOfQuestions - 1
                      ? CustomButton(
                          onPressed: () {
                            _showSubmitConfirmationDialog();
                          },
                          text: 'Finish Quiz',
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
