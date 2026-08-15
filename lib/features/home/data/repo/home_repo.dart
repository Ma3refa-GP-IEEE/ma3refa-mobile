import 'package:dartz/dartz.dart';
import 'package:ma3refa_mobile/core/errors/server_errors.dart';
import 'package:ma3refa_mobile/core/services/dio_services.dart';
import 'package:ma3refa_mobile/core/utils/api_consts.dart';
import 'package:ma3refa_mobile/features/auth/data/models/failuer_model.dart';
import 'package:ma3refa_mobile/features/home/data/models/all_categories_model.dart';
import 'package:ma3refa_mobile/features/home/data/models/sub_category_model.dart';

class HomeRepo {
  final DioServices dioService;

  HomeRepo(this.dioService);

  Future<Either<FailuerModel, AllCategoriesModel>> fetchCategories() async {
    try {
      final response = await dioService.get(
        endpoint: ApiConsts.allCategoriesEndpoint,
      );
      return Right(AllCategoriesModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.failureModel);
    } catch (e) {
      return Left(
        FailuerModel(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<Either<FailuerModel, SubCategoryModel>> fetchSubCategories({
    required int categoryId,
  }) async {
    try {
      final response = await dioService.get(
        endpoint: ApiConsts.subcategoriesEndpoint(categoryId),
      );
      return Right(SubCategoryModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.failureModel);
    } catch (e) {
      return Left(
        FailuerModel(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
