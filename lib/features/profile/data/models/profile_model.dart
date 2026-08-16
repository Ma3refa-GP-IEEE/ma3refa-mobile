import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';

class ProfileModel {
  final UserModel user;
  final int currentStreak;
  final String lastActivity;
  final List<SubcategoryPoints> subcategoryPoints;

  ProfileModel({
    required this.user,
    required this.currentStreak,
    required this.lastActivity,
    required this.subcategoryPoints,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: UserModel.fromJson(json['user']),
      currentStreak: json['streak']['current'] ?? 0,
      lastActivity: json['streak']['last_activity'] ?? '',
      subcategoryPoints: (json['subcategory_points'] as List? ?? [])
          .map((e) => SubcategoryPoints.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'streak': {'current': currentStreak, 'last_activity': lastActivity},
      'subcategory_points': subcategoryPoints.map((e) => e.toJson()).toList(),
    };
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
      subcategory: json['subcategory_name'],
      totalPoints: json['total_points'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subcategory_id': subcategoryId,
      'subcategory_name': subcategory,
      'total_points': totalPoints,
    };
  }
}
