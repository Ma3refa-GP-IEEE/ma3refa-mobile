// ignore_for_file: non_const_argument_for_const_parameter

import 'package:flutter/material.dart';
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';

class SubCategoryModel {
  final int? categoryId;
  final String name;
  final String description;
  final IconData icon;

  const SubCategoryModel({
    required this.name,
    required this.description,
    required this.icon,
    this.categoryId,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    final String subName = json['subcategories']['name'] ?? '';
    final int? subId = json['subcategories']['id'];

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
      categoryId: subId,
      name: subName,
      description:
          localSubData?.description ??
          'Explore comprehensive topics and test your knowledge.',
      icon: localSubData?.icon ?? Icons.category,
    );
  }
}
