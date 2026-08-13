// ignore_for_file: deprecated_member_use
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/result_params.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/quiz_onboardig_screen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/answer_options_widget.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/quiz_progress_widget.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/quiz_timer_widget.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/submit_dialog_widget.dart';

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
        return SubmitDialogWidget(
          onSubmit: () {
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
