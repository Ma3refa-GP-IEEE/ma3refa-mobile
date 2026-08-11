// ignore_for_file: non_const_argument_for_const_parameter

import 'package:flutter/material.dart';

class SubCategoryModel {
  final String name;
  final String description;
  final IconData icon;
  final List<String> topics;

  const SubCategoryModel({
    required this.name,
    required this.description,
    required this.icon,
    required this.topics,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      icon: IconData(
        json['icon'] ?? Icons.category.codePoint,
        fontFamily: json['icon'] ?? Icons.category.fontFamily,
      ),
      topics: List<String>.from(json['topics'] ?? []),
    );
  }
}
