import 'package:anime_and_comic_entertainment/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      paymentHistories: [],
      authentication: {"password": "", "salt": "", "sessionToken": ""},
      bookmarkList: {},
      histories: {},
      username: '',
      avatar: '',
      coinPoint: 0);

  User get user => _user;
  void setUserToken(String token) {
    _user.authentication = {"password": "", "salt": "", "sessionToken": token};
    notifyListeners();
  }

  void setUserId(String id) {
    _user.id = id;
    notifyListeners();
  }

  void setUsername(String username) {
    _user.username = username;
    notifyListeners();
  }

  void setUserAvatar(String avatar) {
    _user.avatar = avatar;
    notifyListeners();
  }

  void setCoinPoint(int coinPoint) {
    _user.coinPoint = coinPoint;
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
