import 'package:anime_and_comic_entertainment/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '65ec67ad05c5cb2ad67cfb3f',
      paymentHistories: [],
      authentication: {"password": "", "salt": "", "sessionToken": ""},
      bookmarkList: {},
      histories: {},
      username: '',
      avatar: '',
      coinPoint: 0,
      questLog: {
        "readingTime": 0,
        "watchingTime": 0,
        "received": [],
        "finalTime": DateTime.now()
      });

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

  void setReadingTime(int time) {
    _user.questLog = {
      "readingTime": _user.questLog["readingTime"] + time,
      "watchingTime": _user.questLog["watchingTime"],
      "received": _user.questLog["received"],
      "finalTime": DateTime.now()
    };
    notifyListeners();
  }

  void setWatchingTime(int time) {
    _user.questLog = {
      "readingTime": _user.questLog["readingTime"],
      "watchingTime": _user.questLog["watchingTime"] + time,
      "received": _user.questLog["received"],
      "finalTime": DateTime.now()
    };
    notifyListeners();
  }

  void setReceived(item) {
    _user.questLog["received"].add(item);
    notifyListeners();
  }

  void setQuestLog(int read, int watching, List received, String date) {
    _user.questLog = {
      "readingTime": read,
      "watchingTime": watching,
      "received": received,
      "finalTime": DateTime.parse(date)
    };
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
