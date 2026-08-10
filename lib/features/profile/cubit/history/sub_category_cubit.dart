import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/features/profile/cubit/history/sub_category_states.dart';
import 'package:ma3refa_mobile/features/profile/data/models/history_quiz_model.dart';
import 'package:ma3refa_mobile/features/profile/data/models/subcategory_quizzes_model.dart';
import 'package:ma3refa_mobile/features/profile/data/repo/history_repo.dart';

class SubcategoryCubit extends Cubit<SubcategoryStates> {
  SubcategoryCubit() : super(SubcategoryInitialState());

  final HistoryRepo _historyRepo = getIt<HistoryRepo>();
  List<HistoryQuizModel> allQuizzes = [];
  int currentPage = 1;
  bool isFetchingMore = false;

  Future<void> fetchSubcategoryQuizzes(
    int subcategoryId, {
    bool loadMore = false,
  }) async {
    if (!loadMore) {
      emit(SubcategoryLoadingState());
      currentPage = 1;
      allQuizzes.clear();
    } else {
      isFetchingMore = true;
    }

    final result = await _historyRepo.getSubcategoryQuizzesHistory(
      subcategoryId: subcategoryId,
      page: currentPage,
    );

    result.fold(
      (failure) {
        isFetchingMore = false;
        emit(SubcategoryErrorState(errorMessage: failure.message));
      },
      (subcategoryQuizzesModel) {
        isFetchingMore = false;
        allQuizzes.addAll(subcategoryQuizzesModel.quizzes);
        final updatedModel = SubcategoryQuizzesModel(
          subcategoryId: subcategoryQuizzesModel.subcategoryId,
          subcategory: subcategoryQuizzesModel.subcategory,
          totalPoints: subcategoryQuizzesModel.totalPoints,
          quizzes: allQuizzes,
          pagination: subcategoryQuizzesModel.pagination,
        );

        if (currentPage < subcategoryQuizzesModel.pagination.totalPages) {
          currentPage++;
        }
        emit(SubcategorySuccessState(subcategoryQuizzesModel: updatedModel));
      },
    );
  }
}
