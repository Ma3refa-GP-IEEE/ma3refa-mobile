import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await sharedPreferences!.setString('token', token);
  }

  static Future<void> saveOnBoarding() async {
    await sharedPreferences!.setBool('onBoarding', true);
  }

  static Future<bool?> getOnBoarding() async {
    return sharedPreferences!.getBool('onBoarding');
  }

  static Future<String?> getToken() async {
    return sharedPreferences!.getString('token');
  }

  static Future<void> saveUserData({
    int? id,
    required String firstName,
    required String lastName,
    required String email,
    required int userAge,
    required String gender,
  }) async {
    await sharedPreferences!.setInt('id', id ?? 0);
    await sharedPreferences!.setString('firstName', firstName);
    await sharedPreferences!.setString('lastName', lastName);
    await sharedPreferences!.setString('email', email);
    await sharedPreferences!.setInt('userAge', userAge);
    await sharedPreferences!.setString('gender', gender);
  }

  static Future<UserModel> getUserData() async {
    int? id = sharedPreferences!.getInt('id');
    String? firstName = sharedPreferences!.getString('firstName');
    String? lastName = sharedPreferences!.getString('lastName');
    String? email = sharedPreferences!.getString('email');
    int? userAge = sharedPreferences!.getInt('userAge');
    String? gender = sharedPreferences!.getString('gender');
    return UserModel.fromJson({
      'id': id,
      'name': '$firstName $lastName',
      'email': email,
      'password': '',
      'age': userAge,
      'gender': gender,
    });
  }

  static Future<void> setLanguage(String language) async {
    await sharedPreferences!.setString('language', language);
  }

  static Future<String?> getLanguage() async {
    return sharedPreferences!.getString('language');
  }

  static Future<void> setThemeMode(bool isDarkMode) async {
    await sharedPreferences!.setBool('isDarkMode', isDarkMode);
  }

  static Future<bool?> getThemeMode() async {
    return sharedPreferences!.getBool('isDarkMode');
  }

  static Future<void> clearData() async {
    await sharedPreferences!.clear();
    await sharedPreferences!.setBool('onBoarding', true);
  }
}
