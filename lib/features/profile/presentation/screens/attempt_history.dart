import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/features/profile/data/models/subcategory_quizzes_model.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/quiz_history_model.dart';
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
                currentPoints: subcategoryQuizzesModel.totalPoints.toDouble(),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Attempt History',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    'Total Attempts: ${subcategoryQuizzesModel.quizzes.length}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
