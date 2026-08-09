import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ma3refa_mobile/core/cache/cache_helper.dart';
import 'package:ma3refa_mobile/core/settings/cubit/app_states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(super.initialState);

  bool isDarkMode = false;
  String languageCode = 'en';

  void loadSettings() {
    isDarkMode = CacheHelper.sharedPreferences?.getBool('isDarkMode') ?? false;
    languageCode = CacheHelper.sharedPreferences?.getString('language') ?? 'en';
    emit(
      AppChangeSettingsState(
        isDarkMode: isDarkMode,
        languageCode: languageCode,
      ),
    );
  }

  void toggleTheme() async {
    isDarkMode = !isDarkMode;
    await CacheHelper.sharedPreferences?.setBool('isDarkMode', isDarkMode);
    emit(
      AppChangeSettingsState(
        isDarkMode: isDarkMode,
        languageCode: languageCode,
      ),
    );
  }

  void changeLanguage(String newLang) async {
    languageCode = newLang;
    await CacheHelper.sharedPreferences?.setString('language', languageCode);
    emit(
      AppChangeSettingsState(
        isDarkMode: isDarkMode,
        languageCode: languageCode,
      ),
    );
  }
}
