import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/features/home/data/models/all_categories_model.dart';
import 'package:ma3refa_mobile/features/home/data/repo/home_repo.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepo homeRepo;
  AllCategoriesModel? lastHomeCategoriesModel;
  HomeCubit(this.homeRepo) : super(HomeInitialState());

  Future<void> getAllHomeCategories() async {
    final cachedData = CacheHelper.getHomeData();
    if (cachedData != null) {
      final cachedModel = AllCategoriesModel.fromJson(cachedData);
      lastHomeCategoriesModel = cachedModel;
      emit(HomeCategoriesSuccessState(allCategoriesModel: cachedModel));
    } else {
      emit(HomeCategoriesLoadingState());
    }
    final result = await homeRepo.fetchCategories();
    result.fold(
      (failure) {
        if (cachedData == null) {
          emit(HomeCategoriesErrorState(error: failure.message));
        }
      },
      (allCategoriesModel) {
        CacheHelper.saveHomeData(allCategoriesModel.toJson());
        lastHomeCategoriesModel = allCategoriesModel;
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
      (categoryModel) {
        emit(SubCategoriesSuccessState(categoryModel: categoryModel));
      },
    );
  }
}
