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

  static int? _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final int? categoryId = _toInt(json['id']) ?? _toInt(json['category_id']);
    final String categoryName = json['name'] ?? '';

    CategoryModel? localData;
    if (categoryName.trim().isNotEmpty) {
      try {
        localData = QuizData.categories.firstWhere(
          (cat) =>
              cat.name.trim().toLowerCase() == categoryName.trim().toLowerCase(),
        );
      } catch (_) {
        localData = null;
      }
    }

    final dynamic subcategoriesJson = json['subcategories'];

    return CategoryModel(
      id: categoryId,
      name: localData?.name ?? categoryName,
      icon: localData?.icon ?? Icons.category,
      color: localData?.color ?? const Color(0xFF000000),
      subCategories: subcategoriesJson is List
          ? List<SubCategoryModel>.from(
              subcategoriesJson.map(
                (e) => SubCategoryModel.fromJson(e),
              ),
            )
          : localData?.subCategories ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon.codePoint,
      'color': color.toARGB32(),
      'subCategories': subCategories.map((e) => e.toJson()).toList(),
    };
  }
}
