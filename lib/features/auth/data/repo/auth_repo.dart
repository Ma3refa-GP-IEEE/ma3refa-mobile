import 'package:dartz/dartz.dart';
import 'package:ma3refa_mobile/core/errors/server_errors.dart';
import 'package:ma3refa_mobile/core/services/dio_services.dart';
import 'package:ma3refa_mobile/core/utils/api_consts.dart';
import 'package:ma3refa_mobile/features/auth/data/models/failuer_model.dart';
import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';

class AuthRepo {
  final DioServices dioService;

  AuthRepo(this.dioService);

  Future<Either<FailuerModel, UserModel>> signUp(UserModel user) async {
    try {
      final response = await dioService.post(
        endpoint: ApiConsts.registerEndpoint,
        body: user.toJson(),
      );
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.failureModel);
    } catch (e) {
      return Left(
        FailuerModel(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<Either<FailuerModel, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioService.post(
        endpoint: ApiConsts.loginEndpoint,
        body: {'email': email, 'password': password},
      );
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.failureModel);
    } catch (e) {
      return Left(
        FailuerModel(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
