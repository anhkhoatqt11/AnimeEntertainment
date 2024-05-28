import 'package:flutter/material.dart';

class NavigatorProvider extends ChangeNotifier {
  bool _show = true;
  bool _isShowNetworkError = false;
  int _bottomIndexNavigator = 0;
  String _currentPage = "Page1";

  bool get isShowNavigator => _show;
  bool get isShowNetworkError => _isShowNetworkError;
  int get bottomIndexNavigator => _bottomIndexNavigator;
  String get currentPage => _currentPage;

  void setNavagatorIndex(int value) {
    _bottomIndexNavigator = value;
    notifyListeners();
  }

  void setCurrentPage(String value) {
    _currentPage = value;
    notifyListeners();
  }

  void setShow(bool value) {
    _show = value;
    notifyListeners();
  }

  void setShowNetworkError(
      bool value, int navigationIndex, String currentPage) {
    _isShowNetworkError = value;
    _bottomIndexNavigator = navigationIndex;
    _currentPage = currentPage;
    notifyListeners();
  }
}
