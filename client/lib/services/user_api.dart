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
            .setShowNetworkError(true);
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
            .setShowNetworkError(true);
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
            .setShowNetworkError(true);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
    }
  }
}
