import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/audio_service.dart';
import 'package:ma3refa_mobile/features/home/data/models/all_categories_model.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/sub_category_screen.dart';
import 'package:ma3refa_mobile/features/home/presentation/widgets/category_card.dart';

class CategoriesGridWidget extends StatelessWidget {
  final AllCategoriesModel allCategoriesModel;

  const CategoriesGridWidget({super.key, required this.allCategoriesModel});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: allCategoriesModel.categories.length,
      itemBuilder: (context, index) {
        final category = allCategoriesModel.categories[index];
        return CategoryCard(
              category: category,
              height: index.isEven ? 200.h : 240.h,
              onTap: () {
                getIt<AudioService>().playAssetSound('sounds/click_cards.wav');
                final int safeCategoryId = category.id ?? -1;
                if (safeCategoryId <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Category is not available right now.'),
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
    );
  }
}
