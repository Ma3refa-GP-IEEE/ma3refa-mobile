import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_cubit.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_states.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/error_at_home_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/sub_category_screen.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/category_card.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/home_header_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/recommendation_widget.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_setup_params.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/quiz_onboardig_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? userName;
  final String? gender;
  const HomeScreen({super.key, this.userName, this.gender});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentUserName = "Guest";
  String currentGender = "male";
  @override
  void initState() {
    super.initState();
    _loadUserData();
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    if (homeCubit.state is HomeInitialState) {
      homeCubit.getAllHomeCategories();
    }
  }

  Future<void> _loadUserData() async {
    List<String>? usernameAndGender = await CacheHelper.getUsernameAndGender();
    setState(() {
      currentUserName = widget.userName ?? usernameAndGender[0];
      currentGender = widget.gender ?? usernameAndGender[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<HomeCubit, HomeStates>(
        builder: (BuildContext context, HomeStates state) {
          final homeCubit = BlocProvider.of<HomeCubit>(context);
          final allCategoriesModel = state is HomeCategoriesSuccessState
              ? state.allCategoriesModel
              : homeCubit.lastHomeCategoriesModel;

          if (state is HomeCategoriesLoadingState && allCategoriesModel == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeInitialState && allCategoriesModel == null) {
            BlocProvider.of<HomeCubit>(context).getAllHomeCategories();
            return const Center(child: CircularProgressIndicator());
          } else if (allCategoriesModel != null) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
              child: RefreshIndicator(
                onRefresh: () async {
                  await BlocProvider.of<HomeCubit>(
                    context,
                  ).getAllHomeCategories();
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HomeHeaderWidget(
                        userName: currentUserName,
                        gender: currentGender,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'home.homeScreen.exploreCategories'.tr(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16.r),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: allCategoriesModel.categories.length,
                        itemBuilder: (context, index) {
                          final category = allCategoriesModel.categories[index];
                          return CategoryCard(
                                category: category,
                                onTap: () {
                                  getIt<AudioService>().playAssetSound(
                                    'sounds/click_cards.wav',
                                  );
                                  final int safeCategoryId = category.id ?? -1;
                                  if (safeCategoryId <= 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Category is not available right now.',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SubCategoryScreen(
                                        categoryId: safeCategoryId,
                                        categoryName: category.name,
                                      ),
                                    ),
                                  );
                                },
                              )
                              .animate()
                              .fade(duration: 400.ms, delay: (index * 100).ms)
                              .scale(
                                begin: const Offset(0.8, 0.8),
                                duration: 400.ms,
                                delay: (index * 100).ms,
                                curve: Curves.easeOutBack,
                              );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'home.homeScreen.recommendedForYou'.tr(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'home.homeScreen.recommendedSubtitle'.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textLight,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 240.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 16.r),
                          itemCount:
                              allCategoriesModel.recommendations.isEmpty
                              ? QuizData.recommendations.length
                              : allCategoriesModel.recommendations.length,
                          itemBuilder: (context, index) {
                            final recommendation =
                                allCategoriesModel.recommendations.isEmpty
                                ? QuizData.recommendations[index]
                                : allCategoriesModel.recommendations[index];
                            return Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    end: 12.w,
                                  ),
                                  child: SizedBox(
                                    width: 280.w,
                                    child: RecommendationWidget(
                                      onTap: () {
                                        getIt<AudioService>().playAssetSound(
                                          'sounds/click_cards.wav',
                                        );
                                        final params = QuizSetupParams(
                                          subcategoryId:
                                              recommendation.subcategoryId,
                                          difficulty: recommendation.difficulty,
                                          numberOfQuestions: 10,
                                          allowedTopics: [recommendation.topic],
                                        );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                QuizOnBoardingScreen(
                                                  quizSetupParams: params,
                                                  quizTitle: recommendation
                                                      .subcategory,
                                                  quizTime: 10,
                                                ),
                                          ),
                                        );
                                      },
                                      topicTitle: recommendation.topic,
                                      difficultyLevel:
                                          recommendation.difficulty,
                                      subCategoryTitle:
                                          recommendation.subcategory,
                                      subCategoryId:
                                          recommendation.subcategoryId,
                                    ),
                                  ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is HomeCategoriesErrorState) {
            return ErrorHomeWidget(errorMessage: state.error);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
