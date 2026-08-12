import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';

class ProfileModel {
  final UserModel user;
  final int currentStreak;
  final List<SubcategoryPoints> subcategoryPoints;

  ProfileModel({
    required this.user,
    required this.currentStreak,
    required this.subcategoryPoints,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: UserModel.fromJson(json),
      currentStreak: json['current_streak'] ?? 0,
      subcategoryPoints: (json['subcategory_points'] as List? ?? [])
          .map((e) => SubcategoryPoints.fromJson(e))
          .toList(),
    );
  }
}

class SubcategoryPoints {
  final int subcategoryId;
  final String subcategory;
  final int totalPoints;

  SubcategoryPoints({
    required this.subcategoryId,
    required this.subcategory,
    required this.totalPoints,
  });

  factory SubcategoryPoints.fromJson(Map<String, dynamic> json) {
    return SubcategoryPoints(
      subcategoryId: json['subcategory_id'],
      subcategory: json['subcategory'],
      totalPoints: json['total_points'],
    );
  }
}
