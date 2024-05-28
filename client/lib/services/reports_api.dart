import 'dart:convert';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ReportsApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/reports/";

  static sendUserReport(BuildContext context, reportContent, userBeReportedId,
      userReportedId, type, destinationId, commentId) async {
    var url = Uri.parse(
      "${baseUrl}sendUserReport",
    );
    try {
      var body = {
        "reportContent": reportContent,
        "userBeReportedId": userBeReportedId,
        "userReportedId": userReportedId,
        "type": type,
        "destinationId": destinationId,
        "commentId": commentId,
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
}
