import 'package:ma3refa_mobile/features/quiz/data/models/quiz_details_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/recorded_quiz_model.dart';

abstract class QuizState {}

class QuizInitialState extends QuizState {}

class GenerateQuizLoadingState extends QuizState {}

class GenerateQuizSuccessState extends QuizState {
  final QuizModel quiz;
  GenerateQuizSuccessState(this.quiz);
}

class GenerateQuizErrorState extends QuizState {
  final String errorMessage;
  GenerateQuizErrorState(this.errorMessage);
}

class FinishQuizLoadingState extends QuizState {}

class FinishQuizSuccessState extends QuizState {
  final RecordedQuizModel recordedQuiz;
  FinishQuizSuccessState(this.recordedQuiz);
}

class FinishQuizErrorState extends QuizState {
  final String errorMessage;
  FinishQuizErrorState(this.errorMessage);
}

class FetchQuizResultsLoadingState extends QuizState {}

class FetchQuizResultsSuccessState extends QuizState {
  final QuizDetailsModel quizDetails;
  FetchQuizResultsSuccessState(this.quizDetails);
}

class FetchQuizResultsErrorState extends QuizState {
  final String errorMessage;
  FetchQuizResultsErrorState(this.errorMessage);
}

class QuizPageChangedState extends QuizState {
  final int index;
  QuizPageChangedState(this.index);
}
