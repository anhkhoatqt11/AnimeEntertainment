// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/model/banner.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/model/donatepackages.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
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
            .setShowNetworkError(true);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
    }
  }
}
