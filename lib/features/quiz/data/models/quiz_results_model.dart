import 'package:ma3refa_mobile/features/quiz/data/models/question_model.dart';

class QuizResultsModel {
  final QuestionModel question;
  final String selectedAnswer;
  final bool isCorrect;
  final String explanation;

  QuizResultsModel({
    required this.question,
    required this.selectedAnswer,
    required this.isCorrect,
    required this.explanation,
  });

  factory QuizResultsModel.fromJson(Map<String, dynamic> json) {
    return QuizResultsModel(
      question: QuestionModel.fromJson(json),
      selectedAnswer: json['selected_answer'] ?? '',
      isCorrect: json['is_correct'] ?? false,
      explanation: json['explanation'] ?? '',
    );
  }
}
