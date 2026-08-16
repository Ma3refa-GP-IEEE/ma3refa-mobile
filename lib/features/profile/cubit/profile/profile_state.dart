import 'package:ma3refa_mobile/features/profile/data/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final ProfileModel profileModel;
  ProfileSuccessState({required this.profileModel});
}

class ProfileErrorState extends ProfileState {
  final String errorMessage;
  final String error;
  ProfileErrorState({required this.errorMessage, required this.error});
}
