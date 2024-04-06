import 'dart:ui';

import 'package:intl/intl.dart';

class Utils {
  static final gradientColors =
      List<Color>.from([Color(0xFFA958FE), Color(0xFFDA5EF0)]);
  static final accentColor = Color(0xFFA958FE);
  static final primaryColor = Color(0xFFDA5EF0);
  static final greenColor = Color.fromARGB(255, 46, 185, 94);
  static final blueColor = Color.fromARGB(255, 63, 172, 255);

  static final top1gradientColors = List<Color>.from(
      [Color.fromARGB(0, 88, 88, 88), Color.fromARGB(255, 218, 94, 240)]);
  static final top2gradientColors = List<Color>.from(
      [Color.fromARGB(0, 88, 88, 88), Color.fromARGB(255, 46, 185, 94)]);
  static final top3gradientColors = List<Color>.from(
      [Color.fromARGB(0, 88, 88, 88), Color.fromARGB(255, 63, 172, 255)]);
  static final topgradientColors = List<Color>.from(
      [Color.fromARGB(0, 88, 88, 88), Color.fromARGB(255, 163, 163, 163)]);
  static bool validateNumberPhone(String str) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (!regExp.hasMatch(str)) {
      return false;
    }
    return true;
  }

  static String convertTotalTime(int value) {
    return "${(value / 60).round()}:${(value % 60)}";
  }

  static String formatNumberWithDots(int number) {
    var formatter = NumberFormat.decimalPattern('vi_VN');
    return (formatter.format(number));
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
