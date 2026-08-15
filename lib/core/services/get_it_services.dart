import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ma3refa_mobile/core/services/dio_services.dart';
import 'package:ma3refa_mobile/core/utils/utils.dart';
import 'package:ma3refa_mobile/features/auth/data/repo/auth_repo.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_cubit.dart';
import 'package:ma3refa_mobile/features/home/data/repo/home_repo.dart';
import 'package:ma3refa_mobile/features/profile/data/repo/history_repo.dart';
import 'package:ma3refa_mobile/features/quiz/data/repo/quiz_repo.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<DioServices>(() => DioServices(getIt<Dio>()));
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt<DioServices>()));
  getIt.registerLazySingleton<HistoryRepo>(
    () => HistoryRepo(getIt<DioServices>()),
  );
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt<DioServices>()));
  getIt.registerLazySingleton<QuizRepo>(() => QuizRepo(getIt<DioServices>()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
  getIt.registerLazySingleton<AudioService>(() => AudioService());
}
