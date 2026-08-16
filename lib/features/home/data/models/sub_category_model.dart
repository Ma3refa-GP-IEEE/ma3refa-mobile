// ignore_for_file: non_const_argument_for_const_parameter

import 'package:flutter/material.dart';
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';

class SubCategoryModel {
  final int? subcategoryId;
  final int? categoryId;
  final String name;
  final String description;
  final IconData icon;

  const SubCategoryModel({
    required this.name,
    required this.description,
    required this.icon,
    this.categoryId,
    this.subcategoryId,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    final String subName = json['name'] ?? '';
    final int? subId = json['id'];
    final int? categoryId = json['category_id'];

    SubCategoryModel? localSubData;
    try {
      localSubData = QuizData.categories
          .expand((cat) => cat.subCategories)
          .firstWhere(
            (sub) =>
                sub.name.trim().toLowerCase() == subName.trim().toLowerCase(),
          );
    } catch (_) {
      localSubData = null;
    }

    return SubCategoryModel(
      subcategoryId: subId,
      categoryId: categoryId,
      name: subName,
      description:
          localSubData?.description ??
          'Explore comprehensive topics and test your knowledge.',
      icon: localSubData?.icon ?? Icons.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subcategory_id': subcategoryId,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'icon': icon.codePoint,
    };
  }
}
