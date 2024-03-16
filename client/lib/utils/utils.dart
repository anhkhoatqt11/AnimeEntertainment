import 'dart:ui';

class Utils {
  static final gradientColors =
      List<Color>.from([Color(0xFFA958FE), Color(0xFFDA5EF0)]);
  static final accentColor = Color(0xFF892ECC);
  static final primaryColor = Color(0xFFDA5EF0);

  static bool validateNumberPhone(String str) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(str)) {
      return false;
    }
    return true;
  }

  static String _validatePassword(String password) {
    String _errorMessage = '';
    if (password.length < 6) {
      _errorMessage += 'Password must be longer than 6 characters.\n';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _errorMessage += '• Uppercase letter is missing.\n';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      _errorMessage += '• Lowercase letter is missing.\n';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      _errorMessage += '• Digit is missing.\n';
    }
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      _errorMessage += '• Special character is missing.\n';
    }
    return _errorMessage;
  }
}
