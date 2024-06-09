// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/avatar.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UsersApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/users/";

  static getAvatarList(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getAvatarList",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<Avatar> avatarCollectionList = [];
        result.forEach((element) {
          avatarCollectionList.add(Avatar(
            collectionName: element['collectionName'],
            avatarList: element['avatarList'],
          ));
        });
        return avatarCollectionList;
      } else {
        return [];
      }
    } catch (e) {
      print(Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError);
      if (Provider.of<NavigatorProvider>(context, listen: false)
              .isShowNetworkError ==
          false) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
    }
  }

  static updateAvatar(BuildContext context, avatarUrl) async {
    var url = Uri.parse(
      "${baseUrl}updateAvatar",
    );
    try {
      var body = {
        "userId": Provider.of<UserProvider>(context, listen: false).user.id,
        "avatarUrl": avatarUrl
      };
      await http.post(url, body: body);
    } catch (e) {
      print(Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError);
      if (Provider.of<NavigatorProvider>(context, listen: false)
              .isShowNetworkError ==
          false) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
    }
  }

  static updateUsername(BuildContext context, username) async {
    var url = Uri.parse(
      "${baseUrl}updateUsername",
    );
    try {
      var body = {
        "userId": Provider.of<UserProvider>(context, listen: false).user.id,
        "username": username
      };
      await http.post(url, body: body);
    } catch (e) {
      print(Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError);
      if (Provider.of<NavigatorProvider>(context, listen: false)
              .isShowNetworkError ==
          false) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
    }
  }

  static paySkycoin(BuildContext context, coin, chapterId) async {
    var url = Uri.parse(
      "${baseUrl}paySkycoin",
    );
    try {
      var body = {
        "userId": Provider.of<UserProvider>(context, listen: false).user.id,
        "coin": coin.toString(),
        "chapterId": chapterId
      };
      final res = await http.put(url, body: body);
      Provider.of<UserProvider>(context, listen: false)
          .setCoinPoint(jsonDecode(res.body)['coinPoint']);
    } catch (e) {
      print(Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError);
      if (Provider.of<NavigatorProvider>(context, listen: false)
              .isShowNetworkError ==
          false) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
    }
  }

  static storeDeviceToken(BuildContext context, token) async {
    var url = Uri.parse(
      "${baseUrl}storeDeviceToken",
    );
    try {
      var body = {
        "userId": Provider.of<UserProvider>(context, listen: false).user.id,
        "token": token
      };
      await http.put(url, body: body);
    } catch (e) {
      print(Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError);
      if (Provider.of<NavigatorProvider>(context, listen: false)
              .isShowNetworkError ==
          false) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
    }
  }

  static sendPushNoti(String userId) async {
    var url = Uri.parse(
      "${baseUrl}sendPushNoti",
    );
    try {
      var body = {
        "title": "Ai đó đã trả lời bình luận của bạn",
        "body": "Hãy kiểm tra ngay",
        "userId": userId
      };
      await http.post(url, body: body);
    } catch (e) {
      return;
    }
  }

  static readNotication(BuildContext context, int index) async {
    var url = Uri.parse(
      "${baseUrl}readNotification",
    );
    try {
      var body = {
        "userId": Provider.of<UserProvider>(context, listen: false).user.id,
        "index": index.toString()
      };
      await http.put(url, body: body);
    } catch (e) {
      return;
    }
  }

  static addCommentNotiToUser(
      String userId, String sourceId, String type) async {
    var url = Uri.parse(
      "${baseUrl}addCommentNotification",
    );
    try {
      var body = {
        "userId": userId,
        "sourceId": sourceId,
        "type": type,
        "content": "Ai đó đã trả lời bình luận của bạn",
      };
      await http.post(url, body: body);
    } catch (e) {
      return;
    }
  }

  static getPaymentHistories(BuildContext context) async {
    var userId = Provider.of<UserProvider>(context, listen: false).user.id;
    var url = Uri.parse(
      "${baseUrl}getPaymentHistories?userId=$userId",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        return result;
      } else {
        return [];
      }
    } catch (e) {
      print(Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError);
      if (Provider.of<NavigatorProvider>(context, listen: false)
              .isShowNetworkError ==
          false) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
    }
    return [];
  }

  static getBookmartList(BuildContext context, userId) async {
    var url = Uri.parse(
      "${baseUrl}getBookmarkList?userId=$userId",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        return result;
      } else {
        return [];
      }
    } catch (e) {
      print(Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError);
      if (Provider.of<NavigatorProvider>(context, listen: false)
              .isShowNetworkError ==
          false) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
    }
  }

  static Future<void> removeBookmark(BuildContext context, String userId,
      List<String> bookmarksToRemove) async {
    var url = Uri.parse("${baseUrl}removeBookmark");
    try {
      var body = {
        "userId": userId,
        "bookmarksToRemove": bookmarksToRemove,
      };
      await http.post(url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      handleNetworkError(context);
    }
  }

  static void handleNetworkError(BuildContext context) {
    print(Provider.of<NavigatorProvider>(context, listen: false)
        .isShowNetworkError);
    if (!Provider.of<NavigatorProvider>(context, listen: false)
        .isShowNetworkError) {
      Provider.of<NavigatorProvider>(context, listen: false)
          .setShowNetworkError(true, 0, "Page1");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }
}
