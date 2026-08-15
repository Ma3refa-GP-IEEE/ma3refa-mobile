import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/result_params.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/untimed_quiz_questions_screen.dart';

mixin UntimedQuizLogicMixin on State<UntimedQuizQuestionsScreen> {
  bool isWrongAnswerTriggered = false;
  late List<Answer> userAnswers;
  late PageController pageController;
  int currentQuestionIndex = 0;
  bool isCurrentQuestionAnswered = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  late ConfettiController confettiController;

  void initUntimedQuizLogic() {
    pageController = PageController(initialPage: 0);
    confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    userAnswers = List.generate(widget.numberOfQuestions, (index) {
      return Answer(
        questionId: index + 1,
        selectedAnswer: 'skipped',
        isCorrect: false,
      );
    });
  }

  void handleAnswerSelection({required String selectedAnswerOption}) async {
    if (isCurrentQuestionAnswered) return;

    final currentQuestion = widget.quizModel.questions[currentQuestionIndex];
    bool isCorrectAnswer =
        (selectedAnswerOption == currentQuestion.correctAnswer);

    setState(() {
      userAnswers[currentQuestionIndex] = Answer(
        questionId: currentQuestion.id,
        selectedAnswer: selectedAnswerOption,
        isCorrect: isCorrectAnswer,
      );
      isCurrentQuestionAnswered = true;
    });

    if (isCorrectAnswer) {
      confettiController.play();
      await getIt<AudioService>().playAssetSound(
        'sounds/coreeeeect-answer.mp3',
      );
    } else {
      setState(() {
        isWrongAnswerTriggered = true;
      });
      await getIt<AudioService>().playAssetSound(
        'sounds/wrong_answer_sound.wav',
      );

      HapticFeedback.heavyImpact();
    }
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < widget.numberOfQuestions - 1) {
      setState(() {
        isCurrentQuestionAnswered = false;
        isWrongAnswerTriggered = false;
      });
      getIt<AudioService>().playAssetSound(
        'assets/sounds/steps_progress_sound.wav',
      );
      confettiController.stop();
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  ResultParams finishAndSubmitQuiz() {
    int finalScore = userAnswers.where((ans) => ans.isCorrect).length;
    return ResultParams(
      score: finalScore,
      answers: userAnswers,
      subcategoryId: widget.subCategoryId,
    );
  }

  void disposeUntimedQuizLogic() {
    pageController.dispose();
    audioPlayer.dispose();
    confettiController.dispose();
  }
}
