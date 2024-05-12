// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/dailyquests.dart';
import 'package:anime_and_comic_entertainment/model/donatepackages.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DailyQuestsApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/quest/";

  static getDailyQuests(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getDailyQuests",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<DailyQuests> dailyQuestList = [];
        result.forEach((element) {
          dailyQuestList.add(DailyQuests(
            id: element['_id'],
            questType: element['questType'],
            questName: element['questName'],
            prize: element['prize'],
            requiredTime: element['requiredTime'],
          ));
        });
        return dailyQuestList;
      } else {
        return [];
      }
    } catch (e) {
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

  static updateQuestLog(BuildContext context, String questId) async {
    var url = Uri.parse(
      "${baseUrl}updateQuestLog",
    );
    try {
      var userInfo = Provider.of<UserProvider>(context, listen: false).user;
      if (userInfo.authentication["sessionToken"] != "") {
        var body = {
          "userId": userInfo.id,
          "readingTime": userInfo.questLog["readingTime"].toString(),
          "watchingTime": userInfo.questLog["watchingTime"].toString(),
          "received": questId,
        };
        var res = await http.post(url, body: body);
        if (res.statusCode == 200) {
          var result = (jsonDecode(res.body));
          Provider.of<UserProvider>(context, listen: false)
              .setCoinPoint(result["coinPoint"]);
        }
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
}
