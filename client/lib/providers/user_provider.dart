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
      notificationSentCount: 0,
      coinPoint: 0,
      questLog: {
        "readingTime": 0,
        "watchingTime": 0,
        "received": [],
        "finalTime": DateTime.now(),
        "hasReceivedDailyGift": false,
      },
      challenges: []);

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

  void minusCoinPoint(int coinPoint) {
    _user.coinPoint -= coinPoint;
    notifyListeners();
  }

  void setNotificationSentCount(int count) {
    _user.notificationSentCount += count;
    notifyListeners();
  }

  void setReadingTime(int time) {
    _user.questLog = {
      "readingTime": _user.questLog["readingTime"] + time,
      "watchingTime": _user.questLog["watchingTime"],
      "received": _user.questLog["received"],
      "finalTime": DateTime.now(),
      "hasReceivedDailyGift": _user.questLog["hasReceivedDailyGift"]
    };
    notifyListeners();
  }

  void setWatchingTime(int time) {
    _user.questLog = {
      "readingTime": _user.questLog["readingTime"],
      "watchingTime": _user.questLog["watchingTime"] + time,
      "received": _user.questLog["received"],
      "finalTime": DateTime.now(),
      "hasReceivedDailyGift": _user.questLog["hasReceivedDailyGift"]
    };
    notifyListeners();
  }

  void setReceived(item) {
    _user.questLog["received"].add(item);
    notifyListeners();
  }

  void setReceivedDailyGift(item) {
    _user.questLog["hasReceivedDailyGift"] = item;
    notifyListeners();
  }

  void setQuestLog(int read, int watching, List received, String date,
      bool hasReceivedDailyGift) {
    _user.questLog = {
      "readingTime": read,
      "watchingTime": watching,
      "received": received,
      "finalTime": DateTime.parse(date),
      "hasReceivedDailyGift": hasReceivedDailyGift
    };
    notifyListeners();
  }

  void setChallenges(List value) {
    _user.challenges = value;
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
