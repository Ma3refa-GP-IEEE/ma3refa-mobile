import 'package:ma3refa_mobile/features/home/data/models/category_model.dart';
import 'package:ma3refa_mobile/features/home/data/models/recommendations_model.dart';

class AllCategoriesModel {
  final List<CategoryModel> categories;
  final List<RecommendationModel> recommendations;

  const AllCategoriesModel({
    required this.categories,
    required this.recommendations,
  });

  factory AllCategoriesModel.fromJson(Map<String, dynamic> json) {
    return AllCategoriesModel(
      categories: List<CategoryModel>.from(
        (json['categories']).map((e) => CategoryModel.fromJson(e)),
      ),
      recommendations: List<RecommendationModel>.from(
        (json['recommendations']).map((e) => RecommendationModel.fromJson(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((e) => e.toJson()).toList(),
      'recommendations': recommendations.map((e) => e.toJson()).toList(),
    };
  }
}
