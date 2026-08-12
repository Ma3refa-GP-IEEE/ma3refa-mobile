class HistoryQuizModel {
  final int quizId;
  final int difficulty;
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
      difficulty: json['difficulty'],
      score: json['score'],
      totalQuestions: json['total_questions'],
      createdAt: json['created_at'],
    );
  }
}
