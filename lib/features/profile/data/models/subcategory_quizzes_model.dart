import 'package:ma3refa_mobile/features/profile/data/models/history_quiz_model.dart';
import 'package:ma3refa_mobile/features/profile/data/models/pagination_model.dart';

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
