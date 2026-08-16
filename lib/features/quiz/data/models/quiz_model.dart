import 'package:ma3refa_mobile/features/quiz/data/models/question_model.dart';

class QuizModel {
  final int quizId;
  final List<QuestionModel> questions;

  QuizModel({required this.quizId, required this.questions});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      quizId: json['data']['quiz_id'] ?? 0,
      questions:
          (json['data']['questions'] as List<dynamic>?)
              ?.map((questionJson) => QuestionModel.fromJson(questionJson))
              .toList() ??
          [],
    );
  }
}
