import 'package:ma3refa_mobile/features/home/data/models/sub_category_model.dart';

abstract class SubCategoryStates {}

class SubCategoryInitialState extends SubCategoryStates {}

class SubCategoryLoadingState extends SubCategoryStates {}

class SubCategorySuccessState extends SubCategoryStates {
  final SubCategoryModel subCategoryModel;
  SubCategorySuccessState({required this.subCategoryModel});
}

class SubCategoryErrorState extends SubCategoryStates {
  final String error;

  SubCategoryErrorState({required this.error});
}
