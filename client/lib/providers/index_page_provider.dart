
import 'package:flutter/material.dart';

class IndexPageProvider extends ChangeNotifier {
  int _indexPage = 0;

  int get indexPage => _indexPage;
  void setIndexPage(int index) {
    _indexPage = index;
    notifyListeners();
  }

}
