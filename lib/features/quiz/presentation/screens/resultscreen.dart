import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/auth/presentation/widgets/custome_button.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/question_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_details_model.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/quiz_review_item_widget.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/quiz_score_card_widget.dart';

class ResultScreen extends StatefulWidget {
  final bool comingFromQuizScreen;
  final QuizDetailsModel quizDetailsModel;

  const ResultScreen({
    super.key,
    required this.quizDetailsModel,
    required this.comingFromQuizScreen,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int numberOfCorrectAnswers() {
    int correctAnswers = 0;
    for (var result in widget.quizDetailsModel.results) {
      if (result.isCorrect) {
        correctAnswers++;
      }
    }
    return correctAnswers;
  }

  String getFullAnswerText(QuestionModel question, String answerLetter) {
    switch (answerLetter.toLowerCase()) {
      case 'a':
        return question.optionA;
      case 'b':
        return question.optionB;
      case 'c':
        return question.optionC;
      case 'd':
        return question.optionD;
      case 'skipped':
        return 'Skipped';
      default:
        return answerLetter;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Quiz Results'),
        centerTitle: true,
        backgroundColor: AppColors.background,
        leading: widget.comingFromQuizScreen
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            QuizScoreCardWidget(
              totalQuestions: widget.quizDetailsModel.totalQuestions,
              correctAnswers: numberOfCorrectAnswers(),
            ),
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Review Answers',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textDark,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.quizDetailsModel.results.length,
              itemBuilder: (context, index) {
                final result = widget.quizDetailsModel.results[index];
                String actualCorrectAnswerText = getFullAnswerText(
                  result.question,
                  result.question.correctAnswer,
                );

                String actualUserAnswerText = getFullAnswerText(
                  result.question,
                  result.selectedAnswer,
                );
                return QuizReviewItemWidget(
                  questionNumber: index + 1,
                  questionText: result.question.description,
                  correctAnswer: actualCorrectAnswerText,
                  userAnswer: actualUserAnswerText,
                  isCorrect: result.isCorrect,
                  explanation: result.explanation,
                );
              },
            ),
            SizedBox(height: 20.h),
            widget.comingFromQuizScreen
                ? CustomButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    text: "Back to Home",
                    icon: Icons.home,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
