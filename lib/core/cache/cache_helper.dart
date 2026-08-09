import 'package:ma3refa_mobile/features/auth/data/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token) async {
    await sharedPreferences!.setString('token', token);
  }

  Future<void> saveOnBoarding() async {
    await sharedPreferences!.setBool('onBoarding', true);
  }

  Future<bool?> getOnBoarding() async {
    return sharedPreferences!.getBool('onBoarding');
  }

  Future<String?> getToken() async {
    return sharedPreferences!.getString('token');
  }

  Future<void> saveUserData({
    required String firstName,
    required String lastName,
    required String email,
    required int userAge,
    required String gender,
  }) async {
    await sharedPreferences!.setString('firstName', firstName);
    await sharedPreferences!.setString('lastName', lastName);
    await sharedPreferences!.setString('email', email);
    await sharedPreferences!.setInt('userAge', userAge);
    await sharedPreferences!.setString('gender', gender);
  }

  Future<UserModel> getUserData() async {
    String? firstName = sharedPreferences!.getString('firstName');
    String? lastName = sharedPreferences!.getString('lastName');
    String? email = sharedPreferences!.getString('email');
    int? userAge = sharedPreferences!.getInt('userAge');
    String? gender = sharedPreferences!.getString('gender');
    return UserModel();
  }

  Future<void> setLanguage(String language) async {
    await sharedPreferences!.setString('language', language);
  }

  Future<String?> getLanguage() async {
    return sharedPreferences!.getString('language');
  }

  Future<void> setThemeMode(bool isDarkMode) async {
    await sharedPreferences!.setBool('isDarkMode', isDarkMode);
  }

  Future<bool?> getThemeMode() async {
    return sharedPreferences!.getBool('isDarkMode');
  }

  Future<void> clearData() async {
    await sharedPreferences!.clear();
    await sharedPreferences!.setBool('onBoarding', true);
  }
}
