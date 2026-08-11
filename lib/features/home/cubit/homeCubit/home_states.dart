import 'package:ma3refa_mobile/features/home/data/models/all_categories_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {
  final AllCategoriesModel allCategoriesModel;

  HomeSuccessState({required this.allCategoriesModel});
}

class HomeErrorState extends HomeStates {
  final String error;

  HomeErrorState({required this.error});
}
