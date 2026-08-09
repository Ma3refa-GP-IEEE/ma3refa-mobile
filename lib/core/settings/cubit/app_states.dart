abstract class AppState {}

class AppInitialState extends AppState {}

class AppChangeSettingsState extends AppState {
  final bool isDarkMode;
  final String languageCode;

  AppChangeSettingsState({
    required this.isDarkMode,
    required this.languageCode,
  });
}
