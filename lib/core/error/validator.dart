class Validators {
  static String? validateEmail(String? value) {
    String pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Please enter email address';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid email address';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value == "") {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm Password is required";
    } else if (confirmPassword != password) {
      return "Passwords do not match";
    } else {
      return null;
    }
  }
}
