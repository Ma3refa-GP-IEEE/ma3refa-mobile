import 'package:flutter/material.dart';
import 'package:ma3refa_mobile/features/home/data/models/sub_category_model.dart';
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';

class CategoryModel {
  final int? id;
  final String name;
  final IconData icon;
  final Color color;
  final List<SubCategoryModel> subCategories;

  const CategoryModel({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final String categoryName = json['name'] ?? '';
    final int? categoryId = json['id'];

    CategoryModel? localData;
    try {
      localData = QuizData.categories.firstWhere(
        (cat) =>
            cat.name.trim().toLowerCase() == categoryName.trim().toLowerCase(),
      );
    } catch (_) {
      localData = null;
    }
    return CategoryModel(
      id: categoryId,
      name: categoryName,
      icon: localData?.icon ?? Icons.category,
      color: localData?.color ?? const Color(0xFF000000),
      subCategories: localData?.subCategories ?? [],
    );
  }
}
