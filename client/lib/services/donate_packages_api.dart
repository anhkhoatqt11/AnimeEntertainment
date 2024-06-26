// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/model/banner.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/model/donatepackages.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DonatePackagesApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/donates/";

  static getDonatePackageList(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getDonatePackageList",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<DonatePackages> donatePackageList = [];
        result.forEach((element) {
          donatePackageList.add(DonatePackages(
            id: element['_id'],
            coverImage: element['coverImage'],
            title: element['title'],
            subTitle: element['subTitle'],
            coin: element['coin'],
          ));
        });
        return donatePackageList;
      } else {
        return [];
      }
    } catch (e) {
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

  static Future<List<Map<String, dynamic>>> getDonatorList(
      BuildContext context) async {
    var url = Uri.parse("${baseUrl}getDonatorList");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = jsonDecode(res.body) as List<dynamic>;
        List<Map<String, dynamic>> donatorList = [];
        result.forEach((element) {
          donatorList.add({
            'username': element['username'],
            'totalCoins': element['totalCoins'],
            'donationCount': element['donationCount'],
            'avatar': element['avatar'],
          });
        });
        return donatorList;
      } else {
        return [];
      }
    } catch (e) {
      if (Provider.of<NavigatorProvider>(context, listen: false)
              .isShowNetworkError ==
          false) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
      return [];
    }
  }

  static Future<bool> uploadDonateRecord(
      BuildContext context, String packageId, String userId) async {
    var url = Uri.parse("${baseUrl}uploadDonateRecord");
    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "packageId": packageId,
          "userId": userId,
          "datetime": DateTime.now().toIso8601String(),
        }),
      );
      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (!Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()),
        );
      }
      return false;
    }
  }

  static Future<bool> processDonationPayment(
      BuildContext context, int? amount, String userId) async {
    var url = Uri.parse("${baseUrl}processDonationPayment");
    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "amount": amount,
          "userId": userId,
        }),
      );
      var currentCoin =
          Provider.of<UserProvider>(context, listen: false).user.coinPoint -
              amount!;
      Provider.of<UserProvider>(context, listen: false)
          .setCoinPoint(currentCoin);
      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (!Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()),
        );
      }
      return false;
    }
  }
}
