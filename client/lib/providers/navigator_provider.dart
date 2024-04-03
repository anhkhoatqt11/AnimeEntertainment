import 'package:flutter/material.dart';

class NavigatorProvider extends ChangeNotifier {
  bool _show = true;

  bool get isShowNavigator => _show;
  void setShow(bool value) {
    _show = value;
    notifyListeners();
  }
}
