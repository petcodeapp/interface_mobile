class ValidatorHelper {
  static String passwordValidator(String password) {
    if (password.trim().length < 7) {
      return 'Please enter a password with a length of at least 8';
    } else {
      return null;
    }
  }

  static String confirmPasswordValidator(
      String password, String confirmPassword) {
    if (password.trim() != confirmPassword.trim()) {
      return 'Passwords don\'t match';
    } else {
      return null;
    }
  }

  static String phoneNumberValidator(String phoneNumber) {
    if (int.tryParse(phoneNumber.trim()) == null) {
      return 'Please enter a valid phone number';
    } else {
      return null;
    }
  }
}
