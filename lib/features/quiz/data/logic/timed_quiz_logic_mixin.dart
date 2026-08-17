// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_cubit.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_cubit.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/result_params.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/timed_quiz_questions_screen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/widgets/submit_dialog_widget.dart';

mixin TimedQuizLogicMixin on State<TimedQuizQuestionsScreen> {
  late int difficultyLevel;
  late List<Answer> userAnswers;
  late PageController pageController;
  int currentQuestionIndex = 0;

  void initQuizLogic() {
    pageController = PageController(initialPage: 0);
    userAnswers = List.generate(widget.numberOfQuestions, (index) {
      return Answer(
        questionId: index + 1,
        selectedAnswer: null,
        isCorrect: false,
      );
    });
  }

  void handleAnswerSelection({required String selectedAnswerOption}) {
    final currentQuestion = widget.quizModel.questions[currentQuestionIndex];

    String selectedLetter = '';
    if (selectedAnswerOption == currentQuestion.optionA) {
      selectedLetter = 'a';
    } else if (selectedAnswerOption == currentQuestion.optionB) {
      selectedLetter = 'b';
    } else if (selectedAnswerOption == currentQuestion.optionC) {
      selectedLetter = 'c';
    } else if (selectedAnswerOption == currentQuestion.optionD) {
      selectedLetter = 'd';
    }

    bool isCorrectAnswer =
        (selectedLetter == currentQuestion.correctAnswer.toLowerCase());

    setState(() {
      userAnswers[currentQuestionIndex] = Answer(
        questionId: currentQuestion.id,
        selectedAnswer: selectedLetter,
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
    difficultyLevel = widget.difficultyLevel.toLowerCase() == 'easy'
        ? 1
        : widget.difficultyLevel.toLowerCase() == 'medium'
        ? 2
        : 3;
    int finalScore = userAnswers.where((ans) => ans.isCorrect).length;
    int subCatId = widget.subCategoryId;
    return ResultParams(
      score: finalScore * difficultyLevel,
      answers: userAnswers,
      subcategoryId: subCatId,
    );
  }

  void showSubmitConfirmationDialog() {
    final parentContext = context;

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      useRootNavigator: true,
      builder: (dialogContext) {
        return SubmitDialogWidget(
          onSubmit: () {
            Navigator.of(dialogContext).pop();

            final params = finishAndSubmitQuiz();
            BlocProvider.of<QuizCubit>(parentContext).finishCurrentQuiz(
              quizId: widget.quizModel.quizId,
              params: params,
            );
            BlocProvider.of<HomeCubit>(context).getAllHomeCategories();
          },
        );
      },
    );
  }

  void disposeQuizLogic() {
    pageController.dispose();
  }
}
