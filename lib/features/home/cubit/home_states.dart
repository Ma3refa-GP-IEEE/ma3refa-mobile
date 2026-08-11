import 'package:ma3refa_mobile/features/home/data/models/all_categories_model.dart';
import 'package:ma3refa_mobile/features/home/data/models/sub_category_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeCategoriesLoadingState extends HomeStates {}

class HomeCategoriesSuccessState extends HomeStates {
  final AllCategoriesModel allCategoriesModel;
  HomeCategoriesSuccessState({required this.allCategoriesModel});
}

class HomeCategoriesErrorState extends HomeStates {
  final String error;
  HomeCategoriesErrorState({required this.error});
}

class SubCategoriesLoadingState extends HomeStates {}

class SubCategoriesSuccessState extends HomeStates {
  final SubCategoryModel subCategoryModel;
  SubCategoriesSuccessState({required this.subCategoryModel});
}

class SubCategoriesErrorState extends HomeStates {
  final String error;
  SubCategoriesErrorState({required this.error});
}
