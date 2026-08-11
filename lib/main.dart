import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/services/get_it_services.dart';
import 'package:ma3refa_mobile/core/settings/cubit/app_cubit.dart';
import 'package:ma3refa_mobile/core/settings/cubit/app_states.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/quiz_setup_screen.dart';
import 'package:ma3refa_mobile/features/home/presentation/screens/sub_category_screen.dart';

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
                home: QuizSetupScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
