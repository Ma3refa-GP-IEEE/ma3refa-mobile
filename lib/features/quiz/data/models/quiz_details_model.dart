import 'package:ma3refa_mobile/features/quiz/data/models/quiz_results_model.dart';

class QuizDetailsModel {
  final int quizId;
  final String subcategory;
  final String difficulty;
  final int score;
  final int totalQuestions;
  final DateTime? createdAt;
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
    final Map<String, dynamic> data =
        json['data'] != null && json['data'] is Map<String, dynamic>
        ? json['data']
        : json;

    return QuizDetailsModel(
      quizId: data['quiz_id'] ?? 0,
      subcategory: data['subcategory'] ?? '',
      difficulty: data['difficulty'] ?? 'Easy',
      score: data['score'] ?? 0,
      totalQuestions: data['total_questions'] ?? 0,
      createdAt: data['created_at'] != null
          ? DateTime.tryParse(data['created_at'] as String)?.toLocal()
          : null,
      results: data['results'] != null
          ? (data['results'] as List)
                .map((e) => QuizResultsModel.fromJson(e))
                .toList()
          : [],
    );
  }
}
