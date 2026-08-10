import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/features/auth/cubit/auth_states.dart';
import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';
import 'package:ma3refa_mobile/features/auth/data/repo/auth_repo.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo = getIt<AuthRepo>();

  AuthCubit() : super(AuthInitialState());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());

    final result = await authRepo.login(email: email, password: password);

    result.fold((failure) => emit(AuthErrorState(message: failure.message)), (
      user,
    ) async {
      await CacheHelper.saveToken(user.token ?? '');

      emit(AuthSuccessState(user: user));
    });
  }

  Future<void> register({
    required String nameController,
    required String emailController,
    required String passwordController,
    required int ageController,
    required String genderController,
  }) async {
    emit(AuthLoadingState());

    final newUser = UserModel(
      name: nameController,
      email: emailController,
      password: passwordController,
      age: ageController,
      gender: genderController,
    );

    final result = await authRepo.signUp(newUser);

    result.fold((failure) => emit(AuthErrorState(message: failure.message)), (
      user,
    ) async {
      await CacheHelper.saveToken(user.token ?? '');

      emit(AuthSuccessState(user: user));
    });
  }

  Future<void> logOut() async {
    await CacheHelper.clearData();
    emit(AuthLoggedOutState());
  }
}
