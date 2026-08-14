import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/settings/cubit/app_cubit.dart';
import 'package:ma3refa_mobile/core/settings/cubit/app_states.dart';
import 'package:ma3refa_mobile/features/auth/cubit/auth_cubit.dart';
import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';
import 'package:ma3refa_mobile/features/auth/presentation/screens/on_boarding_screen.dart';
import 'package:ma3refa_mobile/features/auth/presentation/screens/splash_screen.dart';
import 'package:ma3refa_mobile/features/home/cubit/home_cubit.dart';
import 'package:ma3refa_mobile/features/home/data/repo/home_repo.dart';
import 'package:ma3refa_mobile/features/profile/cubit/history/sub_category_cubit.dart';
import 'package:ma3refa_mobile/features/profile/cubit/profile/profile_cubit.dart';
import 'package:ma3refa_mobile/features/profile/data/models/profile_model.dart';
import 'package:ma3refa_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:ma3refa_mobile/features/quiz/cubit/quiz_cubit.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/question_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_details_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/quiz_results_model.dart';
import 'package:ma3refa_mobile/features/quiz/data/models/result_params.dart';
import 'package:ma3refa_mobile/features/quiz/data/repo/quiz_repo.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/quiz_onboardig_screen.dart';
import 'package:ma3refa_mobile/features/quiz/presentation/screens/resultscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => AppCubit(AppInitialState())..loadSettings(),
        ),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(getIt<HomeRepo>()),
        ),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<SubcategoryCubit>(create: (context) => SubcategoryCubit()),
        BlocProvider<QuizCubit>(
          create: (context) => QuizCubit(getIt<QuizRepo>()),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<AppCubit>(context);
          return ScreenUtilInit(
            designSize: const Size(390, 880),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: 'Ma3refa App',
                themeMode: cubit.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                home: ProfileScreen(
                  profileModel: ProfileModel(
                    user: UserModel(
                      name: 'Mahmoud Abdelghani',
                      email: 'mahmoud@example.com',
                      password: '000000000',
                      age: 22,
                      gender: 'Male',
                    ),
                    currentStreak: 7,
                    lastActivity: '2023-10-01',
                    subcategoryPoints: [
                      SubcategoryPoints(
                        subcategoryId: 1,
                        subcategory: 'Python',
                        totalPoints: 300,
                      ),
                      SubcategoryPoints(
                        subcategoryId: 2,
                        subcategory: 'Mathematics',
                        totalPoints: 250,
                      ),
                      SubcategoryPoints(
                        subcategoryId: 3,
                        subcategory: 'Geography',
                        totalPoints: 90,
                      ),
                    ],
                  ),
                ),
                // home: QuizOnBoardingScreen(
                //   quizModel: QuizModel(
                //     quizId: 5,
                //     questions: [
                //       QuestionModel(
                //         id: 2,
                //         description: 'What is the capital of France?',
                //         optionA: 'London',
                //         optionB: 'Berlin',
                //         optionC: 'Paris',
                //         optionD: 'Madrid',
                //         correctAnswer: 'Paris',
                //         explanation:
                //             'Paris is the capital and most populous city of France. It has been a major center of finance, diplomacy, commerce, fashion, science, and the arts since the 17th century.',
                //       ),
                //       QuestionModel(
                //         id: 2,
                //         description: 'What is the capital of France?',
                //         optionA: 'London',
                //         optionB: 'Berlin',
                //         optionC: 'Paris',
                //         optionD: 'Madrid',
                //         correctAnswer: 'Paris',
                //         explanation:
                //             'Paris is the capital and most populous city of France. It has been a major center of finance, diplomacy, commerce, fashion, science, and the arts since the 17th century.',
                //       ),
                //       QuestionModel(
                //         id: 2,
                //         description: 'What is the capital of France?',
                //         optionA: 'London',
                //         optionB: 'Berlin',
                //         optionC: 'Paris',
                //         optionD: 'Madrid',
                //         correctAnswer: 'Paris',
                //         explanation:
                //             'Paris is the capital and most populous city of France. It has been a major center of finance, diplomacy, commerce, fashion, science, and the arts since the 17th century.',
                //       ),
                //       QuestionModel(
                //         id: 2,
                //         description: 'What is the capital of France?',
                //         optionA: 'London',
                //         optionB: 'Berlin',
                //         optionC: 'Paris',
                //         optionD: 'Madrid',
                //         correctAnswer: 'Paris',
                //         explanation:
                //             'Paris is the capital and most populous city of France. It has been a major center of finance, diplomacy, commerce, fashion, science, and the arts since the 17th century.',
                //       ),
                //       QuestionModel(
                //         id: 2,
                //         description: 'What is the capital of France?',
                //         optionA: 'London',
                //         optionB: 'Berlin',
                //         optionC: 'Paris',
                //         optionD: 'Madrid',
                //         correctAnswer: 'Paris',
                //         explanation:
                //             'Paris is the capital and most populous city of France. It has been a major center of finance, diplomacy, commerce, fashion, science, and the arts since the 17th century.',
                //       ),
                //       QuestionModel(
                //         id: 2,
                //         description: 'What is the capital of France?',
                //         optionA: 'London',
                //         optionB: 'Berlin',
                //         optionC: 'Paris',
                //         optionD: 'Madrid',
                //         correctAnswer: 'Paris',
                //         explanation:
                //             'Paris is the capital and most populous city of France. It has been a major center of finance, diplomacy, commerce, fashion, science, and the arts since the 17th century.',
                //       ),
                //       QuestionModel(
                //         id: 2,
                //         description: 'What is the capital of France?',
                //         optionA: 'London',
                //         optionB: 'Berlin',
                //         optionC: 'Paris',
                //         optionD: 'Madrid',
                //         correctAnswer: 'Paris',
                //         explanation:
                //             'Paris is the capital and most populous city of France. It has been a major center of finance, diplomacy, commerce, fashion, science, and the arts since the 17th century.',
                //       ),
                //     ],
                //   ),
                //   numberOfQuestions: 7,
                //   quizTitle: 'General Knowledge Quiz',
                //   quizTime: 60,
                //   subCategoryId: 10,
                // ),
              );
            },
          );
        },
      ),
    );
  }
}
