// {
//   "subcategory_id": 8,
//   "subcategory": "Python",
//   "total_points": 152,
//   "quizzes": [
//     {
//       "quiz_id": 55,
//       "difficulty": 2,
//       "score": 7,
//       "total_questions": 10,
//       "created_at": "2026-08-04T14:30:00Z"
//     }
//   ],
//   "pagination": {
//     "current_page": 1,
//     "per_page": 10,
//     "total_quizzes": 12,
//     "total_pages": 2
//   }
// }

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
