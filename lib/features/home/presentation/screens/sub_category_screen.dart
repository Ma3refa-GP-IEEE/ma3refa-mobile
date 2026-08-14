import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/custome_listtile.dart';

class SubCategoryScreen extends StatelessWidget {
  final String categoryName; //'History & Geography'
  const SubCategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(categoryName),
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
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
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

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: QuizData.categories
                    .firstWhere((category) => category.name == categoryName)
                    .subCategories
                    .length,
                itemBuilder: (context, index) {
                  return CustomListTileWidget(
                        subCategory: QuizData.categories
                            .firstWhere(
                              (category) => category.name == categoryName,
                            )
                            .subCategories[index],
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
            ],
          ),
        ),
      ),
    );
  }
}
