import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/features/home/data/repo/home_repo.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitialState());

  Future<void> getAllHomeCategories() async {
    emit(HomeCategoriesLoadingState());
    final result = await homeRepo.fetchCategories();
    result.fold(
      (failure) => emit(HomeCategoriesErrorState(error: failure.message)),
      (allCategoriesModel) {
        emit(
          HomeCategoriesSuccessState(allCategoriesModel: allCategoriesModel),
        );
      },
    );
  }

  Future<void> getAllSubCategories({required int categoryId}) async {
    emit(SubCategoriesLoadingState());

    final result = await homeRepo.fetchSubCategories(categoryId: categoryId);

    result.fold(
      (failure) => emit(SubCategoriesErrorState(error: failure.message)),
      (subCategoryModel) {
        emit(SubCategoriesSuccessState(subCategoryModel: subCategoryModel));
      },
    );
  }
}
