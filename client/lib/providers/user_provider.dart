import 'package:anime_and_comic_entertainment/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      paymentHistories: [],
      authentication: {"password": "", "salt": "", "sessionToken": ""},
      bookmarkList: {},
      histories: {});

  User get user => _user;
  void setUserToken(String token) {
    _user.authentication = {"password": "", "salt": "", "sessionToken": token};
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
