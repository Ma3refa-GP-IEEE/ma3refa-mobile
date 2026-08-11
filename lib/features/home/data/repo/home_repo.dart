import 'package:dartz/dartz.dart';
import 'package:ma3refa_mobile/core/errors/server_errors.dart';
import 'package:ma3refa_mobile/core/services/dio_services.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/utils/api_consts.dart';
import 'package:ma3refa_mobile/features/home/data/models/all_categories_model.dart';
import 'package:ma3refa_mobile/features/home/data/models/sub_category_model.dart';

class HomeRepo {
  DioServices dioService = getIt<DioServices>();
  HomeRepo(this.dioService);

  Future<Either<ServerException, AllCategoriesModel>> fetchCategories() async {
    try {
      final response = await dioService.get(
        endpoint: ApiConsts.allCategoriesEndpoint,
      );
      return Right(AllCategoriesModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        ServerException(
          statusCode: 500,
          message: 'An unexpected error occurred: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<ServerException, SubCategoryModel>> fetchSubCategories({
    required int categoryId,
  }) async {
    try {
      final response = await dioService.get(
        endpoint: ApiConsts.subcategoriesEndpoint(categoryId),
      );
      return Right(SubCategoryModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        ServerException(
          statusCode: 500,
          message: 'An unexpected error occurred: ${e.toString()}',
        ),
      );
    }
  }
}
