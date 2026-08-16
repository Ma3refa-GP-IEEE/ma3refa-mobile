import 'package:flutter/material.dart';
import 'package:ma3refa_mobile/features/home/data/models/category_model.dart';
import 'package:ma3refa_mobile/features/home/data/models/recommendations_model.dart';
import 'package:ma3refa_mobile/features/home/data/models/sub_category_model.dart';

class QuizData {
  static const List<RecommendationModel> recommendations = [
    RecommendationModel(
      subcategoryId: 1,
      subcategory: 'Ancient History',
      topic: 'Pharaonic Civilization',
      difficulty: 'Easy',
    ),
    RecommendationModel(
      subcategoryId: 22,
      subcategory: 'Mobile App Development',
      topic: 'Cross-Platform Frameworks (Flutter/React Native)',
      difficulty: 'Medium',
    ),
    RecommendationModel(
      subcategoryId: 5,
      subcategory: 'Astronomy & Space',
      topic: 'Black Holes',
      difficulty: 'Hard',
    ),
    RecommendationModel(
      subcategoryId: 13,
      subcategory: 'Global Tournaments',
      topic: 'FIFA World Cup',
      difficulty: 'Easy',
    ),
    RecommendationModel(
      subcategoryId: 23,
      subcategory: 'Artificial Intelligence & Machine Learning',
      topic: 'Natural Language Processing (NLP)',
      difficulty: 'Hard',
    ),
    RecommendationModel(
      subcategoryId: 11,
      subcategory: 'Cinema & TV',
      topic: 'Academy Awards (Oscars)',
      difficulty: 'Medium',
    ),
    RecommendationModel(
      subcategoryId: 7,
      subcategory: 'Chemistry',
      topic: 'Periodic Table',
      difficulty: 'Easy',
    ),
    RecommendationModel(
      subcategoryId: 25,
      subcategory: 'Software Engineering & Architecture',
      topic: 'Software Design Patterns',
      difficulty: 'Hard',
    ),
  ];
  static const List<CategoryModel> categories = [
    // ==========================================
    // 1. History & Geography
    // ==========================================
    CategoryModel(
      id: 1,
      name: 'History & Geography',
      icon: Icons.public,
      color: Color(0xFFBEE9E8),
      subCategories: [
        SubCategoryModel(
          subcategoryId: 1,
          name: 'Ancient History',
          description:
              'Explore the dawn of human civilization and ancient empires.',
          icon: Icons.account_balance,
        ),
        SubCategoryModel(
          subcategoryId: 2,
          name: 'Modern History',
          description: 'Key events and conflicts that shaped our modern world.',
          icon: Icons.history_edu,
        ),
        SubCategoryModel(
          subcategoryId: 3,
          name: 'World Geography',
          description: 'Discover the physical features and borders of Earth.',
          icon: Icons.map,
        ),
        SubCategoryModel(
          subcategoryId: 4,
          name: 'Landmarks & Tourism',
          description: 'Journey through the most famous landmarks globally.',
          icon: Icons.tour,
        ),
        SubCategoryModel(
          subcategoryId: 5,
          name: 'Dummy Subcategory',
          description: 'Dummy Subcategory Dummy Subcategory Dummy Subcategory',
          icon: Icons.account_balance,
        ),
      ],
    ),

    // ==========================================
    // 2. Science & Nature
    // ==========================================
    CategoryModel(
      id: 2,
      name: 'Science & Nature',
      icon: Icons.science,
      color: Color(0xFFCAE9FF),
      subCategories: [
        SubCategoryModel(
          subcategoryId: 5,
          name: 'Astronomy & Space',
          description: 'Uncover the mysteries of the universe and beyond.',
          icon: Icons.rocket_launch,
        ),
        SubCategoryModel(
          subcategoryId: 6,
          name: 'Biology',
          description:
              'The study of living organisms and their vital processes.',
          icon: Icons.biotech,
        ),
        SubCategoryModel(
          subcategoryId: 7,
          name: 'Chemistry',
          description:
              'Understand the elements and chemical reactions around us.',
          icon: Icons.science_outlined,
        ),
        SubCategoryModel(
          subcategoryId: 8,
          name: 'Earth Sciences & Weather',
          description:
              'Explore our planet\'s climate, weather, and physical layers.',
          icon: Icons.cloud_outlined,
        ),
      ],
    ),

    // ==========================================
    // 3. Arts & Literature
    // ==========================================
    CategoryModel(
      id: 3,
      name: 'Arts & Literature',
      color: Color(0xFFE2EAF2),
      icon: Icons.palette,
      subCategories: [
        SubCategoryModel(
          subcategoryId: 9,
          name: 'World Literature',
          description: 'Dive into classic novels, poetry, and famous authors.',
          icon: Icons.menu_book,
        ),
        SubCategoryModel(
          subcategoryId: 10,
          name: 'Visual Arts',
          description:
              'A journey through painting, sculpture, and visual expression.',
          icon: Icons.brush,
        ),
        SubCategoryModel(
          subcategoryId: 11,
          name: 'Cinema & TV',
          description:
              'Behind the scenes of the silver screen and iconic films.',
          icon: Icons.movie,
        ),
        SubCategoryModel(
          subcategoryId: 12,
          name: 'Music',
          description:
              'The universal language of melodies and classical composers.',
          icon: Icons.music_note,
        ),
      ],
    ),

    // ==========================================
    // 4. Sports & Health
    // ==========================================
    CategoryModel(
      id: 4,
      name: 'Sports & Health',
      icon: Icons.sports_soccer,
      color: Color(0xFFD4E6F1),
      subCategories: [
        SubCategoryModel(
          subcategoryId: 13,
          name: 'Global Tournaments',
          description:
              'Test your knowledge on the world\'s biggest sporting events.',
          icon: Icons.emoji_events,
        ),
        SubCategoryModel(
          subcategoryId: 14,
          name: 'Individual Sports',
          description: 'Focus on athletes and solo competitive sports.',
          icon: Icons.sports_gymnastics,
        ),
        SubCategoryModel(
          subcategoryId: 15,
          name: 'Nutrition',
          description: 'Learn about diets, vitamins, and healthy lifestyles.',
          icon: Icons.restaurant,
        ),
        SubCategoryModel(
          subcategoryId: 16,
          name: 'Public Health',
          description: 'Essentials of mental health, first aid, and immunity.',
          icon: Icons.health_and_safety,
        ),
      ],
    ),

    // ==========================================
    // 5. Technology & Programming
    // ==========================================
    CategoryModel(
      id: 5,
      name: 'Technology & Programming',
      icon: Icons.computer,
      color: Color(0xFFE8F6F3),
      subCategories: [
        SubCategoryModel(
          subcategoryId: 17,
          name: 'Programming Fundamentals',
          description: 'The core building blocks and logic of coding.',
          icon: Icons.code,
        ),
        SubCategoryModel(
          subcategoryId: 18,
          name: 'Programming Languages',
          description:
              'Explore syntax and concepts of popular coding languages.',
          icon: Icons.terminal,
        ),
        SubCategoryModel(
          subcategoryId: 19,
          name: 'Web Development',
          description: 'Building and designing the modern web.',
          icon: Icons.web,
        ),
        SubCategoryModel(
          subcategoryId: 20,
          name: 'Databases',
          description: 'Managing, querying, and structuring data efficiently.',
          icon: Icons.storage,
        ),
        SubCategoryModel(
          subcategoryId: 21,
          name: 'Cybersecurity',
          description: 'Protecting systems, networks, and data from attacks.',
          icon: Icons.security,
        ),
        SubCategoryModel(
          subcategoryId: 22,
          name: 'Mobile App Development',
          description: 'Crafting native and cross-platform mobile experiences.',
          icon: Icons.smartphone,
        ),
        SubCategoryModel(
          subcategoryId: 23,
          name: 'Artificial Intelligence & ML',
          description: 'Dive into neural networks and predictive systems.',
          icon: Icons.psychology,
        ),
        SubCategoryModel(
          subcategoryId: 24,
          name: 'Cloud Computing & DevOps',
          description:
              'Deploying, scaling, and maintaining software in the cloud.',
          icon: Icons.cloud_sync,
        ),
        SubCategoryModel(
          subcategoryId: 25,
          name: 'Software Engineering & Arch.',
          description:
              'Best practices, patterns, and methodologies in software.',
          icon: Icons.architecture,
        ),
      ],
    ),
  ];

  static List<SubCategoryModel> getSubCategoriesByCategoryName(
    String categoryName,
  ) {
    try {
      return categories
          .firstWhere((cat) => cat.name == categoryName)
          .subCategories;
    } catch (e) {
      return [];
    }
  }

  static IconData getIconForSubcategory(String subcategoryName) {
    for (var category in categories) {
      for (var subCategory in category.subCategories) {
        if (subCategory.name.contains(subcategoryName)) {
          return subCategory.icon;
        }
      }
    }
    return Icons.category;
  }
}
