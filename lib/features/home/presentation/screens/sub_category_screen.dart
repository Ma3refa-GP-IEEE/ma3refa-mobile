import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_cubit.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_states.dart';
import 'package:ma3refa_mobile/features/home/data/models/sub_category_model.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/quiz_setup_screen.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/custome_listtile.dart';

class SubCategoryScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const SubCategoryScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(
      context,
    ).getAllSubCategories(categoryId: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is SubCategoriesErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        List<SubCategoryModel> displayList = [];
        if (state is SubCategoriesSuccessState) {
          displayList = state.categoryModel.subCategories;
        } else {
          final localCategoryMatch = QuizData.categories
              .where((category) => category.name == widget.categoryName)
              .toList();
          displayList = localCategoryMatch.isNotEmpty
              ? localCategoryMatch.first.subCategories
              : [];
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            title: Text(widget.categoryName),
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
            leading: IconButton(
              color: AppColors.background,
              icon: Icon(Icons.arrow_back_ios, color: AppColors.textDark),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: state is SubCategoriesLoadingState
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 8.r,
                      end: 8.r,
                      bottom: 16.r,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Text(
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              'home.subCategory.selectTopic'.tr(),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ),
                        if (displayList.isEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 50.h),
                            child: Text(
                              "No topics found!",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.textLight,
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: displayList.length,
                            itemBuilder: (context, index) {
                              return CustomListTileWidget(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QuizSetupScreen(
                                            subCategoryId: displayList[index]
                                                .subcategoryId!,
                                            quizTitle: displayList[index].name,
                                          ),
                                        ),
                                      );
                                    },
                                    subCategory: displayList[index],
                                  )
                                  .animate()
                                  .fade(
                                    duration: 400.ms,
                                    delay: (index * 100).ms,
                                  )
                                  .slideY(
                                    begin: 0.2,
                                    duration: 400.ms,
                                    delay: (index * 100).ms,
                                    curve: Curves.easeOutQuad,
                                  );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
