import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {
  final UserModel user;
  AuthSuccessState({required this.user});
}

class AuthLoggedOutState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String message;
  AuthErrorState({required this.message});
}
