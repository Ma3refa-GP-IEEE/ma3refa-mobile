import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_state.dart';
import 'package:ma3refa_mobile/features/profile/data/models/profile_model.dart';
import 'package:ma3refa_mobile/features/profile/data/repo/history_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  final HistoryRepo _historyRepo = getIt<HistoryRepo>();

  Future<void> fetchProfileHistory() async {
    final cachedData = CacheHelper.getProfileData();
    if (cachedData != null) {
      final cachedModel = ProfileModel.fromJson(cachedData);
      emit(ProfileSuccessState(profileModel: cachedModel));
    } else {
      emit(ProfileLoadingState());
    }
    final result = await _historyRepo.getProfileHistory();
    result.fold(
      (failure) {
        if (cachedData == null) {
          emit(
            ProfileErrorState(
              errorMessage: 'Failed to fetch profile history',
              error: failure.message,
            ),
          );
        }
      },
      (profileModel) {
        CacheHelper.saveProfileData(profileModel.toJson());
        emit(ProfileSuccessState(profileModel: profileModel));
      },
    );
  }
}
