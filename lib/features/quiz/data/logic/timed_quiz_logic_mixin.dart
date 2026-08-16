// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/result_params.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/timed_quiz_questions_screen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/submit_dialog_widget.dart';

mixin TimedQuizLogicMixin on State<TimedQuizQuestionsScreen> {
  late List<Answer> userAnswers;
  late PageController pageController;
  int currentQuestionIndex = 0;

  void initQuizLogic() {
    pageController = PageController(initialPage: 0);
    userAnswers = List.generate(widget.numberOfQuestions, (index) {
      return Answer(
        questionId: index + 1,
        selectedAnswer: 'skipped',
        isCorrect: false,
      );
    });
  }

  void handleAnswerSelection({required String selectedAnswerOption}) {
    final currentQuestion = widget.quizModel.questions[currentQuestionIndex];
    bool isCorrectAnswer =
        (selectedAnswerOption == currentQuestion.correctAnswer);

    setState(() {
      userAnswers[currentQuestionIndex] = Answer(
        questionId: currentQuestion.id,
        selectedAnswer: selectedAnswerOption,
        isCorrect: isCorrectAnswer,
      );
    });

    if (currentQuestionIndex < widget.numberOfQuestions - 1) {
      Future.delayed(const Duration(milliseconds: 400), () {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    }
  }

  ResultParams finishAndSubmitQuiz() {
    int finalScore = userAnswers.where((ans) => ans.isCorrect).length;
    int subCatId = widget.subCategoryId;
    return ResultParams(
      score: finalScore,
      answers: userAnswers,
      subcategoryId: subCatId,
    );
  }

  void showSubmitConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      useRootNavigator: true,
      builder: (context) {
        return SubmitDialogWidget(
          onSubmit: () {
            Navigator.of(context).pop();
            // final result = finishAndSubmitQuiz();
            // BlocProvider.of<QuizCubit>(context).finishCurrentQuiz(result);
          },
        );
      },
    );
  }

  void disposeQuizLogic() {
    pageController.dispose();
  }
}
