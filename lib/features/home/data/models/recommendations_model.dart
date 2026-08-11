import 'package:flutter/material.dart';
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';

class RecommendationModel {
  final int subcategoryId;
  final String subcategory;
  final String topic;
  final int difficulty;
  final String description;
  final IconData icon;

  const RecommendationModel({
    required this.subcategoryId,
    required this.subcategory,
    required this.topic,
    required this.difficulty,
    required this.description,
    required this.icon,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    final String subName = json['subcategory'] ?? '';

    dynamic localSubCategory;
    try {
      localSubCategory = QuizData.categories
          .expand((cat) => cat.subCategories)
          .firstWhere(
            (sub) =>
                sub.name.trim().toLowerCase() == subName.trim().toLowerCase(),
          );
    } catch (_) {
      localSubCategory = null;
    }
    return RecommendationModel(
      subcategoryId: json['subcategory_id'] ?? 0,
      subcategory: subName,
      topic: json['topic'] ?? '',
      difficulty: json['difficulty'] ?? 1,
      description: localSubCategory?.description ?? '',
      icon: localSubCategory?.icon ?? Icons.star_border,
    );
  }
}
