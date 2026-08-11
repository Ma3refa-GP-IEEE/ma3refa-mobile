import 'package:ma3refa_mobile/features/quiz/data/models/quiz_results_model.dart';

class QuizDetailsModel {
  final int quizId;
  final String subcategory;
  final int difficulty;
  final int score;
  final int totalQuestions;
  final String createdAt;
  final List<QuizResultsModel> results;

  QuizDetailsModel({
    required this.quizId,
    required this.subcategory,
    required this.difficulty,
    required this.score,
    required this.totalQuestions,
    required this.createdAt,
    required this.results,
  });

  factory QuizDetailsModel.fromJson(Map<String, dynamic> json) {
    List<QuizResultsModel> results = (json['results'] as List)
        .map((e) => QuizResultsModel.fromJson(e))
        .toList();

    return QuizDetailsModel(
      quizId: json['quiz_id'] ?? 0,
      subcategory: json['subcategory'] ?? '',
      difficulty: json['difficulty'] ?? 0,
      score: json['score'] ?? 0,
      totalQuestions: json['total_questions'] ?? 0,
      createdAt: json['created_at'] ?? '',
      results: results,
    );
  }
}
