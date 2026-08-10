import 'package:dartz/dartz.dart';
import 'package:ma3refa_mobile/core/errors/server_errors.dart';
import 'package:ma3refa_mobile/core/services/dio_services.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/api_consts.dart';
import 'package:ma3refa_mobile/features/auth/data/models/failuer_model.dart';
import 'package:ma3refa_mobile/features/profile/data/models/profile_model.dart';
import 'package:ma3refa_mobile/features/profile/data/models/subcategory_quizzes_model.dart';

class HistoryRepo {
  DioServices dioService = getIt<DioServices>();
  HistoryRepo(this.dioService);

  Future<Either<FailuerModel, ProfileModel>> getProfileHistory() async {
    try {
      final response = await dioService.get(
        endpoint: ApiConsts.userProfileEndpoint,
      );
      return Right(ProfileModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(
        FailuerModel(statusCode: e.statusCode ?? 400, message: e.message),
      );
    } catch (e) {
      return Left(
        FailuerModel(
          statusCode: 500,
          message: 'There was an unexpected error, please try again later',
        ),
      );
    }
  }

  Future<Either<FailuerModel, SubcategoryQuizzesModel>>
  getSubcategoryQuizzesHistory({
    required int subcategoryId,
    int page = 1,
  }) async {
    try {
      final response = await dioService.get(
        endpoint: ApiConsts.quizzesHistoryEndpoint(subcategoryId),
        queryParameters: {'page': page},
      );
      return Right(SubcategoryQuizzesModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(
        FailuerModel(statusCode: e.statusCode ?? 400, message: e.message),
      );
    } catch (e) {
      return Left(
        FailuerModel(
          statusCode: 500,
          message: 'There was an unexpected error, please try again later',
        ),
      );
    }
  }
}
