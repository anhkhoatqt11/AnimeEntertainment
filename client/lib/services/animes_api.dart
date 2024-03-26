// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/banner.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnimesApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/animes/";

  static getAllAnimes(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getAllAnimes",
    );
    try {
      final res = await http.get(url);
      var result = (jsonDecode(res.body));
      List<Animes> animeArray = [];
      if (res.statusCode == 200) {
        result.forEach((element) {
          animeArray.add(Animes(
              id: element['_id'],
              movieName: element['movieName'],
              coverImage: element['coverImage'],
              landspaceImage: element['landspaceImage'],
              genres: element['genreNames']));
        });
        return animeArray;
      } else {
        return [];
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }
}
