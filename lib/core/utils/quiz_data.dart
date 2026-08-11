import 'package:flutter/material.dart';
import 'package:ma3refa_mobile/features/home/data/models/category_model.dart';
import 'package:ma3refa_mobile/features/home/data/models/sub_category_model.dart';

class QuizData {
  static const List<CategoryModel> categories = [
    // ==========================================
    // 1. History & Geography
    // ==========================================
    CategoryModel(
      name: 'History & Geography',
      icon: Icons.public,
      color: Color(0xFFBEE9E8),
      subCategories: [
        SubCategoryModel(
          name: 'Ancient History',
          description:
              'Explore the dawn of human civilization and ancient empires.',
          icon: Icons.account_balance,
        ),
        SubCategoryModel(
          name: 'Modern History',
          description: 'Key events and conflicts that shaped our modern world.',
          icon: Icons.history_edu,
        ),
        SubCategoryModel(
          name: 'World Geography',
          description: 'Discover the physical features and borders of Earth.',
          icon: Icons.map,
        ),
        SubCategoryModel(
          name: 'Landmarks & Tourism',
          description: 'Journey through the most famous landmarks globally.',
          icon: Icons.tour,
        ),
      ],
    ),

    // ==========================================
    // 2. Science & Nature
    // ==========================================
    CategoryModel(
      name: 'Science & Nature',
      icon: Icons.science,
      color: Color(0xFFCAE9FF),
      subCategories: [
        SubCategoryModel(
          name: 'Astronomy & Space',
          description: 'Uncover the mysteries of the universe and beyond.',
          icon: Icons.rocket_launch,
        ),
        SubCategoryModel(
          name: 'Biology',
          description:
              'The study of living organisms and their vital processes.',
          icon: Icons.biotech,
        ),
        SubCategoryModel(
          name: 'Chemistry',
          description:
              'Understand the elements and chemical reactions around us.',
          icon: Icons.science_outlined,
        ),
        SubCategoryModel(
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
      name: 'Arts & Literature',
      color: Color(0xFFE2EAF2),
      icon: Icons.palette,
      subCategories: [
        SubCategoryModel(
          name: 'World Literature',
          description: 'Dive into classic novels, poetry, and famous authors.',
          icon: Icons.menu_book,
        ),
        SubCategoryModel(
          name: 'Visual Arts',
          description:
              'A journey through painting, sculpture, and visual expression.',
          icon: Icons.brush,
        ),
        SubCategoryModel(
          name: 'Cinema & TV',
          description:
              'Behind the scenes of the silver screen and iconic films.',
          icon: Icons.movie,
        ),
        SubCategoryModel(
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
      name: 'Sports & Health',
      icon: Icons.sports_soccer,
      color: Color(0xFFD4E6F1),
      subCategories: [
        SubCategoryModel(
          name: 'Global Tournaments',
          description:
              'Test your knowledge on the world\'s biggest sporting events.',
          icon: Icons.emoji_events,
        ),
        SubCategoryModel(
          name: 'Individual Sports',
          description: 'Focus on athletes and solo competitive sports.',
          icon: Icons.sports_gymnastics,
        ),
        SubCategoryModel(
          name: 'Nutrition',
          description: 'Learn about diets, vitamins, and healthy lifestyles.',
          icon: Icons.restaurant,
        ),
        SubCategoryModel(
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
      name: 'Technology & Programming',
      icon: Icons.computer,
      color: Color(0xFFE8F6F3),
      subCategories: [
        SubCategoryModel(
          name: 'Programming Fundamentals',
          description: 'The core building blocks and logic of coding.',
          icon: Icons.code,
        ),
        SubCategoryModel(
          name: 'Programming Languages',
          description:
              'Explore syntax and concepts of popular coding languages.',
          icon: Icons.terminal,
        ),
        SubCategoryModel(
          name: 'Web Development',
          description: 'Building and designing the modern web.',
          icon: Icons.web,
        ),
        SubCategoryModel(
          name: 'Databases',
          description: 'Managing, querying, and structuring data efficiently.',
          icon: Icons.storage,
        ),
        SubCategoryModel(
          name: 'Cybersecurity',
          description: 'Protecting systems, networks, and data from attacks.',
          icon: Icons.security,
        ),
        SubCategoryModel(
          name: 'Mobile App Development',
          description: 'Crafting native and cross-platform mobile experiences.',
          icon: Icons.smartphone,
        ),
        SubCategoryModel(
          name: 'Artificial Intelligence & ML',
          description: 'Dive into neural networks and predictive systems.',
          icon: Icons.psychology, // أيقونة ممتازة جداً للذكاء الاصطناعي
        ),
        SubCategoryModel(
          name: 'Cloud Computing & DevOps',
          description:
              'Deploying, scaling, and maintaining software in the cloud.',
          icon: Icons.cloud_sync,
        ),
        SubCategoryModel(
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
}
