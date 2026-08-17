import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/custom_snackbar.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/profile/cubit/history/sub_category_cubit.dart';
import 'package:ma3refa_mobile/features/profile/cubit/history/sub_category_states.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/quiz_history_card.dart';
import 'package:ma3refa_mobile/features/profile/presentation/widgets/star_rating_widget.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_cubit.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_states.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/resultscreen.dart';

class AttemptHistoryScreen extends StatefulWidget {
  final int subcategoryId;
  final String subcategoryName;
  const AttemptHistoryScreen({
    super.key,
    required this.subcategoryId,
    required this.subcategoryName,
  });

  @override
  State<AttemptHistoryScreen> createState() => _AttemptHistoryScreenState();
}

class _AttemptHistoryScreenState extends State<AttemptHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SubcategoryCubit>(
      context,
    ).fetchSubcategoryQuizzes(widget.subcategoryId);
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final cubit = BlocProvider.of<SubcategoryCubit>(context);
      if (!cubit.isFetchingMore) {
        cubit.fetchSubcategoryQuizzes(widget.subcategoryId, loadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizCubit, QuizState>(
      listener: (context, state) {
        if (state is FetchQuizResultsLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is FetchQuizResultsSuccessState) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                quizDetailsModel: state.quizDetailsModel,
                comingFromQuizScreen: false,
              ),
            ),
          );
        } else if (state is FetchQuizResultsErrorState) {
          Navigator.pop(context);
          CustomSnackBar.show(
            context: context,
            title: 'Error',
            message: state.errorMessage,
            contentType: ContentType.failure,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(widget.subcategoryName),
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
        body: SafeArea(
          child: BlocBuilder<SubcategoryCubit, SubcategoryStates>(
            builder: (context, state) {
              if (state is SubcategoryLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is SubcategoryErrorState) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              if (state is SubcategorySuccessState) {
                final model = state.subcategoryQuizzesModel;

                if (model.quizzes.isEmpty) {
                  return Center(child: Text("No attempts yet!".tr()));
                }

                return SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      Padding(
                            padding: EdgeInsets.all(8.r),
                            child: StarRatingWidget(
                              maxPoints: 500,
                              currentPoints: model.totalPoints.toDouble(),
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
                                      'count': model.quizzes.length.toString(),
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
                          )
                          .animate(delay: 200.ms)
                          .fade(duration: 300.ms)
                          .slideX(begin: -0.1),
                      SizedBox(height: 16.h),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: model.quizzes.length,
                        itemBuilder: (context, index) {
                          final quiz = model.quizzes[index];
                          return QuizHistoryCard(
                                quizTitle: model.subcategory,
                                score: quiz.score,
                                totalQuestions: quiz.totalQuestions,
                                createdAt: quiz.createdAt,
                                difficulty: quiz.difficulty,
                                onTap: () {
                                  BlocProvider.of<QuizCubit>(
                                    context,
                                  ).getQuizDetails(quizId: quiz.quizId);
                                },
                              )
                              .animate(delay: (300 + (index * 100)).ms)
                              .fade(duration: 400.ms)
                              .slideY(begin: 0.2, curve: Curves.easeOutBack);
                        },
                      ),
                      if (BlocProvider.of<SubcategoryCubit>(
                        context,
                      ).isFetchingMore)
                        Padding(
                          padding: EdgeInsets.all(16.r),
                          child: const CircularProgressIndicator(),
                        ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
