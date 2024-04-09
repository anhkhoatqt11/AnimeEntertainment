import 'package:flutter/material.dart';

class NavigatorProvider extends ChangeNotifier {
  bool _show = true;
  bool _isShowNetworkError = false;

  bool get isShowNavigator => _show;
  bool get isShowNetworkError => _isShowNetworkError;
  void setShow(bool value) {
    _show = value;
    notifyListeners();
  }

  void setShowNetworkError(bool value) {
    _isShowNetworkError = value;
    notifyListeners();
  }
}
