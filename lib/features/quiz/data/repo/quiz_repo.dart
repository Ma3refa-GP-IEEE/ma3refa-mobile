import 'package:dartz/dartz.dart';
import 'package:ma3refa_mobile/core/errors/server_errors.dart';
import 'package:ma3refa_mobile/core/services/dio_services.dart';
import 'package:ma3refa_mobile/core/utils/api_consts.dart';
import 'package:ma3refa_mobile/features/auth/data/models/failuer_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_details_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_setup_params.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/recorded_quiz_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/result_params.dart';

class QuizRepo {
  final DioServices dioService;

  QuizRepo(this.dioService);

  Future<Either<FailuerModel, QuizModel>> generateQuiz({
    required QuizSetupParams params,
  }) async {
    try {
      final response = await dioService.post(
        endpoint: ApiConsts.generateQuizEndpoint,
        body: params.toJson(),
      );
      return Right(QuizModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.failureModel);
    } catch (e) {
      return Left(
        FailuerModel(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<Either<FailuerModel, RecordedQuizModel>> finishQuiz({
    required int quizId,
    required ResultParams params,
  }) async {
    try {
      final response = await dioService.post(
        endpoint: ApiConsts.finishQuizEndpoint(quizId),
        body: params.toJson(),
      );
      return Right(RecordedQuizModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.failureModel);
    } catch (e) {
      return Left(
        FailuerModel(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<Either<FailuerModel, QuizDetailsModel>> fetchQuizResults({
    required int quizId,
  }) async {
    try {
      final response = await dioService.get(
        endpoint: ApiConsts.quizDetailsEndpoint(quizId),
      );
      return Right(QuizDetailsModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.failureModel);
    } catch (e) {
      return Left(
        FailuerModel(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
