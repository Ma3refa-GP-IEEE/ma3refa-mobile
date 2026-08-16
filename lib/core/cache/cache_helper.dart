import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ma3refa_mobile/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await secureStorage.write(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  static Future<void> saveUserData({
    int? id,
    required String firstName,
    required String lastName,
    required String email,
    required int userAge,
    required String gender,
  }) async {
    await secureStorage.write(key: 'id', value: (id ?? 0).toString());
    await secureStorage.write(key: 'firstName', value: firstName);
    await secureStorage.write(key: 'lastName', value: lastName);
    await secureStorage.write(key: 'email', value: email);
    await secureStorage.write(key: 'userAge', value: userAge.toString());
    await secureStorage.write(key: 'gender', value: gender);
  }

  static Future<UserModel> getUserData() async {
    String? idStr = await secureStorage.read(key: 'id');
    String? firstName = await secureStorage.read(key: 'firstName');
    String? lastName = await secureStorage.read(key: 'lastName');
    String? email = await secureStorage.read(key: 'email');
    String? ageStr = await secureStorage.read(key: 'userAge');
    String? gender = await secureStorage.read(key: 'gender');

    return UserModel.fromJson({
      'id': idStr != null ? int.parse(idStr) : 0,
      'name': '$firstName $lastName',
      'email': email,
      'password': '',
      'age': ageStr != null ? int.parse(ageStr) : 0,
      'gender': gender,
    });
  }

  static Future<List<String>> getUsernameAndGender() async {
    String? firstName = await secureStorage.read(key: 'firstName') ?? "Mahmoud";
    String? lastName = await secureStorage.read(key: 'lastName') ?? "Ahmed";
    String? fullName = '$firstName $lastName';
    String? gender = await secureStorage.read(key: 'gender') ?? "Male";
    return [fullName, gender];
  }

  static Future<void> saveOnBoarding() async {
    await sharedPreferences!.setBool('onBoarding', true);
  }

  static Future<bool?> getOnBoarding() async {
    return sharedPreferences!.getBool('onBoarding');
  }

  static Future<void> saveHomeData(Map<String, dynamic> homeData) async {
    String encodedData = jsonEncode(homeData);
    await sharedPreferences!.setString('home_data', encodedData);
  }

  static Map<String, dynamic>? getHomeData() {
    String? encodedData = sharedPreferences!.getString('home_data');
    if (encodedData != null) {
      return jsonDecode(encodedData) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<void> saveProfileData(Map<String, dynamic> profileData) async {
    String encodedData = jsonEncode(profileData);
    await sharedPreferences!.setString('profile_data', encodedData);
  }

  static Map<String, dynamic>? getProfileData() {
    String? encodedData = sharedPreferences!.getString('profile_data');
    if (encodedData != null) {
      return jsonDecode(encodedData) as Map<String, dynamic>;
    }
    return null;
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
    await secureStorage.deleteAll();
    await sharedPreferences!.setBool('onBoarding', true);
  }
}
