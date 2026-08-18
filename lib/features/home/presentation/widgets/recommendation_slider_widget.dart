import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/audio_service.dart';
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';
import 'package:ma3refa_mobile/features/home/data/models/all_categories_model.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/recommendation_widget.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_setup_params.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/quiz_onboardig_screen.dart';

class RecommendationSliderWidget extends StatelessWidget {
  final AllCategoriesModel allCategoriesModel;

  const RecommendationSliderWidget({
    super.key,
    required this.allCategoriesModel,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: allCategoriesModel.recommendations.isEmpty
          ? QuizData.recommendations.length
          : allCategoriesModel.recommendations.length,
      options: CarouselOptions(
        height: 270.h,
        enlargeCenterPage: true,
        enlargeFactor: 0.22,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      itemBuilder: (context, index, realIndex) {
        final recommendation = allCategoriesModel.recommendations.isEmpty
            ? QuizData.recommendations[index]
            : allCategoriesModel.recommendations[index];

        return RecommendationWidget(
              onTap: () {
                getIt<AudioService>().playAssetSound('sounds/click_cards.wav');
                final params = QuizSetupParams(
                  subcategoryId: recommendation.subcategoryId,
                  difficulty: recommendation.difficulty,
                  numberOfQuestions: 10,
                  allowedTopics: [recommendation.topic],
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizOnBoardingScreen(
                      quizSetupParams: params,
                      quizTitle: recommendation.subcategory,
                      quizTime: 10,
                    ),
                  ),
                );
              },
              topicTitle: recommendation.topic,
              difficultyLevel: recommendation.difficulty,
              subCategoryTitle: recommendation.subcategory,
              subCategoryId: recommendation.subcategoryId,
            )
            .animate()
            .fade(duration: 400.ms, delay: (index * 100).ms)
            .slideY(
              begin: 0.2,
              duration: 400.ms,
              delay: (index * 100).ms,
              curve: Curves.easeOutQuad,
            );
      },
    );
  }
}
