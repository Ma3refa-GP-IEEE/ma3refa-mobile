// ignore_for_file: non_const_argument_for_const_parameter

import 'package:flutter/material.dart';
import 'package:ma3refa_mobile/features/home/data/models/sub_category_model.dart';

class CategoryModel {
  final String name;
  final IconData icon;
  final Color color;
  final List<SubCategoryModel> subCategories;

  const CategoryModel({
    required this.name,
    required this.icon,
    required this.color,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? '',
      icon: IconData(
        json['icon'] ?? Icons.category.codePoint,
        fontFamily: json['icon'] ?? Icons.category.fontFamily,
      ), // You can customize this based on your needs
      subCategories: List<SubCategoryModel>.from(
        (json['subCategories'] ?? []).map((e) => SubCategoryModel.fromJson(e)),
      ),
      color: Color(json['color'] ?? 0xFF000000),
    );
  }
}
