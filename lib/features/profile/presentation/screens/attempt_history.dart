import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/profile/data/models/subcategory_quizzes_model.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/quiz_history_card.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/star_rating_widget.dart';

class AttemptHistoryScreen extends StatelessWidget {
  final SubcategoryQuizzesModel subcategoryQuizzesModel;
  const AttemptHistoryScreen({
    super.key,
    required this.subcategoryQuizzesModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(subcategoryQuizzesModel.subcategory),
        titleTextStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Padding(
                  padding: EdgeInsets.all(8.r),
                  child: StarRatingWidget(
                    maxPoints: 500,
                    currentPoints: subcategoryQuizzesModel.totalPoints
                        .toDouble(),
                  ),
                )
                .animate()
                .fade(duration: 400.ms)
                .slideY(begin: -0.1, curve: Curves.easeOut),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'attempt_history'.tr(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    'total_attempts'.tr(
                      namedArgs: {
                        'count': subcategoryQuizzesModel.quizzes.length
                            .toString(),
                      },
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ).animate(delay: 200.ms).fade(duration: 300.ms).slideX(begin: -0.1),
            SizedBox(height: 16.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subcategoryQuizzesModel.quizzes.length,
              itemBuilder: (context, index) {
                final quiz = subcategoryQuizzesModel.quizzes[index];
                return QuizHistoryCard(
                      quizTitle: subcategoryQuizzesModel.subcategory,
                      score: quiz.score,
                      totalQuestions: quiz.totalQuestions,
                      createdAt: quiz.createdAt,
                      difficulty: quiz.difficulty,
                      onTap: () {},
                    )
                    .animate(delay: (300 + (index * 100)).ms)
                    .fade(duration: 400.ms)
                    .slideY(begin: 0.2, curve: Curves.easeOutBack);
              },
            ),
          ],
        ),
      ),
    );
  }
}
