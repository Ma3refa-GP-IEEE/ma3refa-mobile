import 'package:ma3refa_mobile/features/profile/data/models/subcategory_quizzes_model.dart';

abstract class SubcategoryStates {}

class SubcategoryInitialState extends SubcategoryStates {}

class SubcategoryLoadingState extends SubcategoryStates {}

class SubcategorySuccessState extends SubcategoryStates {
  final SubcategoryQuizzesModel subcategoryQuizzesModel;
  SubcategorySuccessState({required this.subcategoryQuizzesModel});
}

class SubcategoryErrorState extends SubcategoryStates {
  final String errorMessage;
  SubcategoryErrorState({required this.errorMessage});
}
