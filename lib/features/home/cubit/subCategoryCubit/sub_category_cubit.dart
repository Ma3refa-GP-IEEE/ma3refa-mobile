import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/features/home/cubit/subCategoryCubit/sub_category_states.dart';
import 'package:ma3refa_mobile/features/home/data/repo/home_repo.dart';

class SubCategoryCubit extends Cubit<SubCategoryStates> {
  SubCategoryCubit() : super(SubCategoryInitialState());
  final HomeRepo homeRepo = getIt<HomeRepo>();

  Future<void> getAllSubCategories({required int categoryId}) async {
    emit(SubCategoryLoadingState());

    final result = await homeRepo.fetchSubCategories(categoryId: categoryId);

    result.fold(
      (failure) => emit(SubCategoryErrorState(error: failure.message)),
      (subCategoryModel) async {
        emit(SubCategorySuccessState(subCategoryModel: subCategoryModel));
      },
    );
  }
}
