import 'dart:convert';
import 'dart:math';

import 'package:anime_and_comic_entertainment/model/notification.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class NotificationApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/users/";

  static getNotification(BuildContext context, String userId) async {
    var url = Uri.parse(
      "${baseUrl}getNotification?userId=$userId",
    );
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var result = (jsonDecode(response.body));
        print(result);
        List<Notifications> notis = [];

        result.forEach((element) {
          Notifications notifications = Notifications(
              sourceId: element['sourceId'],
              type: element['type'],
              content: element['content'],
              status: element['status'],
              sentTime: element['sentTime']);
          notis.add(notifications);
        });

        return notis;
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
}
