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
          topics: [
            'Pharaonic Civilization',
            'Roman Empire',
            'Ancient Greek Civilization',
            'Maya Civilization',
            'Ancient Mythology',
          ],
        ),
        SubCategoryModel(
          name: 'Modern History',
          description: 'Key events and conflicts that shaped our modern world.',
          icon: Icons.history_edu,
          topics: [
            'World War I',
            'World War II',
            'Industrial Revolution',
            'Cold War',
            'Discovery of the Americas',
          ],
        ),
        SubCategoryModel(
          name: 'World Geography',
          description: 'Discover the physical features and borders of Earth.',
          icon: Icons.map,
          topics: [
            'Country Capitals',
            'Rivers and Lakes',
            'Mountain Ranges',
            'Oceans',
            'Deserts',
          ],
        ),
        SubCategoryModel(
          name: 'Landmarks & Tourism',
          description: 'Journey through the most famous landmarks globally.',
          icon: Icons.tour,
          topics: [
            'Seven Wonders of the World',
            'Global Museums',
            'Historic Castles and Palaces',
            'Ancient Temples',
          ],
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
          topics: [
            'Solar System Planets',
            'Black Holes',
            'Galaxies',
            'Space Exploration',
            'Satellites',
          ],
        ),
        SubCategoryModel(
          name: 'Biology',
          description:
              'The study of living organisms and their vital processes.',
          icon: Icons.biotech,
          topics: [
            'Human Body Systems',
            'Botany',
            'Zoology',
            'Genetics',
            'Cell Biology',
          ],
        ),
        SubCategoryModel(
          name: 'Chemistry',
          description:
              'Understand the elements and chemical reactions around us.',
          icon: Icons.science_outlined,
          topics: [
            'Periodic Table',
            'Chemical Reactions',
            'Organic Compounds',
            'Acids and Bases',
            'States of Matter',
          ],
        ),
        SubCategoryModel(
          name: 'Earth Sciences & Weather',
          description:
              'Explore our planet\'s climate, weather, and physical layers.',
          icon: Icons.cloud_outlined,
          topics: [
            'Earthquakes and Volcanoes',
            'Earth\'s Layers',
            'Water Cycle',
            'Climate Change',
          ],
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
          topics: [
            'Classic Novels',
            'Poetry',
            'Plays',
            'Science Fiction Literature',
            'Nobel Laureates in Literature',
          ],
        ),
        SubCategoryModel(
          name: 'Visual Arts',
          description:
              'A journey through painting, sculpture, and visual expression.',
          icon: Icons.brush,
          topics: [
            'Renaissance Art',
            'Impressionism',
            'Abstract Art',
            'Famous Paintings and Painters',
          ],
        ),
        SubCategoryModel(
          name: 'Cinema & TV',
          description:
              'Behind the scenes of the silver screen and iconic films.',
          icon: Icons.movie,
          topics: [
            'Academy Awards (Oscars)',
            'History of Cinema',
            'Film Directors',
            'Cinematography Techniques',
          ],
        ),
        SubCategoryModel(
          name: 'Music',
          description:
              'The universal language of melodies and classical composers.',
          icon: Icons.music_note,
          topics: [
            'Classical Music',
            'Musical Instruments',
            'Music Theory',
            'Famous Composers',
          ],
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
          topics: [
            'FIFA World Cup',
            'Olympic Games',
            'Grand Slam Tennis Tournaments',
            'Formula 1 Racing',
          ],
        ),
        SubCategoryModel(
          name: 'Individual Sports',
          description: 'Focus on athletes and solo competitive sports.',
          icon: Icons.sports_gymnastics,
          topics: [
            'Swimming',
            'Athletics (Track and Field)',
            'Gymnastics',
            'Boxing',
            'Weightlifting',
          ],
        ),
        SubCategoryModel(
          name: 'Nutrition',
          description: 'Learn about diets, vitamins, and healthy lifestyles.',
          icon: Icons.restaurant,
          topics: [
            'Vitamins and Minerals',
            'Proteins and Carbohydrates',
            'Healthy Diets',
            'Calorie Counting',
          ],
        ),
        SubCategoryModel(
          name: 'Public Health',
          description: 'Essentials of mental health, first aid, and immunity.',
          icon: Icons.health_and_safety,
          topics: [
            'First Aid',
            'Immune System',
            'Viruses and Bacteria',
            'Mental Health',
          ],
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
          topics: [
            'Variables',
            'Loops',
            'Conditionals',
            'Basic Algorithms',
            'Data Structures',
          ],
        ),
        SubCategoryModel(
          name: 'Programming Languages',
          description:
              'Explore syntax and concepts of popular coding languages.',
          icon: Icons.terminal,
          topics: ['Python', 'JavaScript', 'C++', 'Java', 'Swift'],
        ),
        SubCategoryModel(
          name: 'Web Development',
          description: 'Building and designing the modern web.',
          icon: Icons.web,
          topics: [
            'HTML and CSS Basics',
            'UI/UX Design',
            'Servers',
            'Hosting and Domains',
            'Web Frameworks',
          ],
        ),
        SubCategoryModel(
          name: 'Databases',
          description: 'Managing, querying, and structuring data efficiently.',
          icon: Icons.storage,
          topics: [
            'SQL',
            'Relational Databases',
            'NoSQL',
            'Database Queries',
            'Data Backups',
          ],
        ),
        SubCategoryModel(
          name: 'Cybersecurity',
          description: 'Protecting systems, networks, and data from attacks.',
          icon: Icons.security,
          topics: [
            'Encryption',
            'Social Engineering',
            'Malware',
            'Firewalls',
            'Two-Factor Authentication (2FA)',
          ],
        ),
        SubCategoryModel(
          name: 'Mobile App Development',
          description: 'Crafting native and cross-platform mobile experiences.',
          icon: Icons.smartphone,
          topics: [
            'iOS Development',
            'Android Development',
            'Cross-Platform Frameworks',
            'Mobile UI Design',
            'App Store Publishing',
          ],
        ),
        SubCategoryModel(
          name: 'Artificial Intelligence & ML',
          description: 'Dive into neural networks and predictive systems.',
          icon: Icons.psychology, // أيقونة ممتازة جداً للذكاء الاصطناعي
          topics: [
            'Neural Networks',
            'Natural Language Processing (NLP)',
            'Computer Vision',
            'Deep Learning',
            'Predictive Analytics',
          ],
        ),
        SubCategoryModel(
          name: 'Cloud Computing & DevOps',
          description:
              'Deploying, scaling, and maintaining software in the cloud.',
          icon: Icons.cloud_sync,
          topics: [
            'Cloud Service Providers',
            'Containerization (Docker)',
            'CI/CD',
            'Serverless Architecture',
            'Kubernetes',
          ],
        ),
        SubCategoryModel(
          name: 'Software Engineering & Arch.',
          description:
              'Best practices, patterns, and methodologies in software.',
          icon: Icons.architecture,
          topics: [
            'OOP',
            'Software Design Patterns',
            'Agile Methodology',
            'Microservices',
            'Software Testing and QA',
          ],
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
