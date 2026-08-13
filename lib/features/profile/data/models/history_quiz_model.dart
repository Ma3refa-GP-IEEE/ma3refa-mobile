// {
//             "quiz_id": 5,
//             "difficulty": 2,
//             "score": 2,
//             "total_questions": 3,
//             "created_at": "2026-08-11 15:58:37"
//         }
class HistoryQuizModel {
  final int quizId;
  final String difficulty;
  final int score;
  final int totalQuestions;
  final String createdAt;

  HistoryQuizModel({
    required this.quizId,
    required this.difficulty,
    required this.score,
    required this.totalQuestions,
    required this.createdAt,
  });

  factory HistoryQuizModel.fromJson(Map<String, dynamic> json) {
    return HistoryQuizModel(
      quizId: json['quiz_id'],
      difficulty: json['difficulty'] ?? 'Easy',
      score: json['score'],
      totalQuestions: json['total_questions'],
      createdAt: json['created_at'],
    );
  }
}
