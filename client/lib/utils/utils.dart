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

  static String validatePassword(String password) {
    String _errorMessage = '';
    if (password.length <= 6) {
      _errorMessage += 'Mật khẩu phải có tối thiểu 6 kí tự \n';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      _errorMessage += '• Chưa có kí tự in hoa.\n';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      _errorMessage += '• Chưa có kí tự số.\n';
    }
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      _errorMessage += '• Chưa có kí tự đặc biệt.\n';
    }
    return _errorMessage;
  }
}
