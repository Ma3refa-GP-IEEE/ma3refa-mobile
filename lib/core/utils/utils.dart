import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Utils {
  static String getAvatarUrl({
    required String userName,
    required String gender,
  }) {
    switch (gender.toLowerCase()) {
      case 'male':
      case 'm':
        return 'assets/images/boy.jpg';
      case 'female':
      case 'f':
        return 'assets/images/girl.jpg';
      default:
        final cleanSeed = Uri.encodeComponent(userName);
        return 'https://api.dicebear.com/7.x/bottts/png?seed=$cleanSeed';
    }
  }
}

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isMuted = false;

  void toggleMute() {
    isMuted = !isMuted;
    if (isMuted) {
      stopSound();
    }
  }

  Future<void> playAssetSound(String assetPath) async {
    if (isMuted) return;
    try {
      await _audioPlayer.play(AssetSource(assetPath));
    } catch (e) {
      debugPrint('Failed to play sound asset "$assetPath": $e');
    }
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }

  void disposeAudioPlayer() {
    _audioPlayer.dispose();
  }
}

class AppValidators {
  static String? validateFirstName(String? firstName) {
    if (firstName == null || firstName.trim().isEmpty) {
      return 'Please enter your first name';
    }
    if (firstName.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? validateLastName(String? lastName) {
    if (lastName == null || lastName.trim().isEmpty) {
      return 'Please enter your last name';
    }
    if (lastName.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? validateEmailInLogin(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Please enter your email address';
    }
    if (!RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    ).hasMatch(email.trim())) {
      return 'Please enter a valid email format';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? confirmPassword,
    String originalPassword,
  ) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (confirmPassword != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateAge(String? age) {
    if (age == null || age.trim().isEmpty) {
      return 'Please enter your age';
    }
    final ageValue = int.tryParse(age.trim());
    if (ageValue == null || ageValue < 5 || ageValue > 100) {
      return 'Please enter a valid age (5 - 100)';
    }
    return null;
  }

  static String? validateEmailInSignUp(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    ).hasMatch(email.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String handleApiError(dynamic error) {
    if (error is DioException) {
      if (error.response != null && error.response?.data != null) {
        final data = error.response!.data;

        if (data['errors'] != null) {
          final Map<String, dynamic> errors = data['errors'];
          if (errors.isNotEmpty) {
            final firstErrorList = errors.values.first;
            if (firstErrorList is List && firstErrorList.isNotEmpty) {
              return firstErrorList.first.toString();
            }
          }
        }

        if (data['message'] != null) {
          return data['message'].toString();
        }
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return 'Connection timeout, please check your internet.';
        case DioExceptionType.connectionError:
          return 'No internet connection.';
        default:
          return 'Something went wrong, please try again.';
      }
    }

    return error.toString();
  }
}
