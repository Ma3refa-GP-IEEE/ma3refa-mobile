class Utils {
  static String getAvatarUrl({
    required String userName,
    required String gender,
  }) {
    final cleanSeed = Uri.encodeComponent(userName);
    switch (gender.toLowerCase()) {
      case 'male':
        return 'https://api.dicebear.com/7.x/avataaars/svg?seed=$cleanSeed';
      case 'female':
        return 'https://api.dicebear.com/7.x/lorelei/svg?seed=$cleanSeed';
      default:
        return 'https://api.dicebear.com/7.x/bottts/svg?seed=$cleanSeed';
    }
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
