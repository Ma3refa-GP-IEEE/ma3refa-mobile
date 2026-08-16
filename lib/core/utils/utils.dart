import 'package:audioplayers/audioplayers.dart';
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

  Future<void> playAssetSound(String assetPath) async {
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
    if (firstName == null || firstName.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  static String? validateLastName(String? lastName) {
    if (lastName == null || lastName.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  static String? validateEmailInLogin(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email address';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  static String? Function(String?) validateConfirmPassword(
    String originalPassword,
  ) {
    return (String? confirmPassword) {
      if (confirmPassword == null || confirmPassword.isEmpty) {
        return 'Please confirm your password';
      }
      if (confirmPassword != originalPassword) {
        return 'Passwords do not match';
      }
      return null;
    };
  }

  static String? validateAge(String? age) {
    if (age == null || age.isEmpty) {
      return 'Please enter your age';
    }
    final ageValue = int.tryParse(age);
    if (ageValue == null || ageValue < 0 || ageValue > 100) {
      return 'Please enter a valid age';
    }
    return null;
  }

  static String? validateEmailInSignUp(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    ).hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
