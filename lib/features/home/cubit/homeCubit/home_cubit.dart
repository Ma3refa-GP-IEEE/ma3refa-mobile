import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/features/home/cubit/homeCubit/home_states.dart';
import 'package:ma3refa_mobile/features/home/data/repo/home_repo.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  final HomeRepo homeRepo = getIt<HomeRepo>();

  Future<void> getAllHomeCategories() async {
    emit(HomeLoadingState());

    final result = await homeRepo.fetchCategories();

    result.fold((failure) => emit(HomeErrorState(error: failure.message)), (
      allCategoriesModel,
    ) async {
      emit(HomeSuccessState(allCategoriesModel: allCategoriesModel));
    });
  }
}
