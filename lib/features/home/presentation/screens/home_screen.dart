import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';
import 'package:ma3refa_mobile/core/utils/quiz_data.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/sub_category_screen.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/category_card.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/home_header_widget.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/recommendation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HomeHeaderWidget(userName: 'Mahmoud Abdelghani', gender: 'male'),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'home.homeScreen.exploreCategories'.tr(),
                  style: TextStyle(fontSize: 18.sp, color: AppColors.primary),
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
                itemCount: QuizData.categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: QuizData.categories[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubCategoryScreen(
                            categoryName: QuizData.categories[index].name,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'home.homeScreen.recommendedForYou'.tr(),
                  style: TextStyle(fontSize: 18.sp, color: AppColors.textDark),
                ),
              ),
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'home.homeScreen.recommendedSubtitle'.tr(),
                  style: TextStyle(fontSize: 14.sp, color: AppColors.textLight),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 240.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  itemCount: QuizData.categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: SizedBox(
                        width: 280.w,
                        child: RecommendationWidget(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
