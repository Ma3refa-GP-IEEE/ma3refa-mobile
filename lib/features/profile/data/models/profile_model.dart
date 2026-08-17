import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';

class ProfileModel {
  final UserModel user;
  final int currentStreak;
  final DateTime? lastActivity;
  final int allUserCompletedQuizzes;
  final int allUsertotalPoints;
  final List<SubcategoryPoints> subcategoryPoints;

  ProfileModel({
    required this.user,
    required this.currentStreak,
    required this.lastActivity,
    required this.subcategoryPoints,
    required this.allUserCompletedQuizzes,
    required this.allUsertotalPoints,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
        json.containsKey('data') && json['data'] != null ? json['data'] : json;

    return ProfileModel(
      user: UserModel.fromJson(data['user'] ?? {}),
      currentStreak: data['streak']?['current'] ?? 0,
      lastActivity: data['streak']?['last_activity'] != null
          ? DateTime.tryParse(
              data['streak']?['last_activity'] as String,
            )?.toLocal()
          : null,
      subcategoryPoints: (data['subcategory_points'] as List? ?? [])
          .map((e) => SubcategoryPoints.fromJson(e))
          .toList(),
      allUserCompletedQuizzes: data['stats']?['completed_quizzes'] ?? 0,
      allUsertotalPoints: data['stats']?['total_points'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'streak': {
        'current': currentStreak,
        'last_activity': lastActivity?.toIso8601String(),
      },
      'subcategory_points': subcategoryPoints.map((e) => e.toJson()).toList(),
      'stats': {
        'completed_quizzes': allUserCompletedQuizzes,
        'total_points': allUsertotalPoints,
      },
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
