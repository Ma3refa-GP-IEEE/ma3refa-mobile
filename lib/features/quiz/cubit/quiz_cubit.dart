import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_states.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_setup_params.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/result_params.dart';
import 'package:ma3refa_mobile/features/quiz/data/repo/quiz_repo.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepo quizRepo;
  QuizCubit(this.quizRepo) : super(QuizInitialState());

  Future<void> generateNewQuiz({required QuizSetupParams params}) async {
    emit(GenerateQuizLoadingState());
    final result = await quizRepo.generateQuiz(params: params);
    result.fold(
      (failure) => emit(GenerateQuizErrorState(failure.message)),
      (quizModel) => emit(GenerateQuizSuccessState(quizModel)),
    );
  }

  Future<void> finishCurrentQuiz({
    required int quizId,
    required ResultParams params,
  }) async {
    emit(FinishQuizLoadingState());
    final result = await quizRepo.finishQuiz(quizId: quizId, params: params);
    result.fold(
      (failure) => emit(FinishQuizErrorState(failure.message)),
      (recordedQuiz) => emit(FinishQuizSuccessState(recordedQuiz)),
    );
  }

  Future<void> getQuizDetails({required int quizId}) async {
    emit(FetchQuizResultsLoadingState());
    final result = await quizRepo.fetchQuizResults(quizId: quizId);
    result.fold(
      (failure) => emit(FetchQuizResultsErrorState(failure.message)),
      (quizDetails) => emit(FetchQuizResultsSuccessState(quizDetails)),
    );
  }
}
