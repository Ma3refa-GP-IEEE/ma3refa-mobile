import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_state.dart';
import 'package:ma3refa_mobile/features/profile/data/repo/history_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  final HistoryRepo _historyRepo = getIt<HistoryRepo>();

  Future<void> fetchProfileHistory() async {
    emit(ProfileLoadingState());
    final result = await _historyRepo.getProfileHistory();
    result.fold(
      (failure) => emit(ProfileErrorState(errorMessage: failure.message)),
      (profileModel) => emit(ProfileSuccessState(profileModel: profileModel)),
    );
  }
}
