import 'package:ma3refa_mobile/features/profile/data/models/history_quiz_model.dart';
import 'package:ma3refa_mobile/features/profile/data/models/pagination_model.dart';

// {
//     "subcategory_id": 2,
//     "subcategory": "Python",
//     "total_points": 10,
//     "quizzes": [
//         {
//             "quiz_id": 6,
//             "difficulty": 2,
//             "score": 8,
//             "total_questions": 8,
//             "created_at": "2026-08-12 15:19:36"
//         },
//         {
//             "quiz_id": 5,
//             "difficulty": 2,
//             "score": 2,
//             "total_questions": 3,
//             "created_at": "2026-08-11 15:58:37"
//         }
//     ],
//     "pagination": {
//         "current_page": 1,
//         "per_page": 10,
//         "total_quizzes": 2,
//         "total_pages": 1
//     }
// }
class SubcategoryQuizzesModel {
  final int subcategoryId;
  final String subcategory;
  final int totalPoints;
  final List<HistoryQuizModel> quizzes;
  final PaginationModel pagination;

  SubcategoryQuizzesModel({
    required this.subcategoryId,
    required this.subcategory,
    required this.totalPoints,
    required this.quizzes,
    required this.pagination,
  });

  factory SubcategoryQuizzesModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryQuizzesModel(
      subcategoryId: json['subcategory_id'],
      subcategory: json['subcategory'],
      totalPoints: json['total_points'],
      quizzes: (json['quizzes'] as List? ?? [])
          .map((e) => HistoryQuizModel.fromJson(e))
          .toList(),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }
}
