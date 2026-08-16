class RecommendationModel {
  final int subcategoryId;
  final String subcategory;
  final String topic;
  final String difficulty;

  const RecommendationModel({
    required this.subcategoryId,
    required this.subcategory,
    required this.topic,
    required this.difficulty,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    final String subName = json['subcategory'] ?? '';
    return RecommendationModel(
      subcategoryId: json['subcategory_id'] ?? 0,
      subcategory: subName,
      topic: json['topic'] ?? '',
      difficulty: json['difficulty'] ?? 'Easy',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subcategory_id': subcategoryId,
      'subcategory': subcategory,
      'topic': topic,
      'difficulty': difficulty,
    };
  }
}
