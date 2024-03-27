// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/banner.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnimesApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/animes/";

  static getAnimeBanner(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getAnimeBanner",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<BannerItem> bannerArray = [];
        result['list'].forEach((element) {
          bannerArray.add(BannerItem(
              bannerImage: element['bannerImage'], urlId: element['urlId']));
        });
        return bannerArray;
      } else {
        return [];
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static getAnimeAlbum(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getAnimeAlbum",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<AnimeAlbum> animeAlbumArray = [];
        result.forEach((element) {
          animeAlbumArray.add(AnimeAlbum(
              id: element['_id'],
              albumName: element['albumName'],
              animeList: element['detailList']));
        });
        return animeAlbumArray;
      } else {
        return [];
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static getAnimeAlbumContent(
      BuildContext context, albumId, limit, page) async {
    var url = Uri.parse(
      "${baseUrl}getAnimeInAlbum",
    );
    try {
      var body = {
        "idAlbum": albumId,
        "limit": limit,
        "page": page,
      };
      final res = await http.post(url, body: body);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<Animes> animeAlbumItemArray = [];
        result[0]['detailList'].forEach((element) {
          if (element.length > 0) {
            animeAlbumItemArray.add(Animes(
              id: element['_id'],
              movieName: element['movieName'],
              coverImage: element['coverImage'],
            ));
          }
        });
        return animeAlbumItemArray;
      } else {
        return [];
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static getNewEpisodeAnime(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getNewEpisodeAnime",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<AnimeEpisodes> newEpisodeArray = [];
        result.forEach((element) {
          newEpisodeArray.add(AnimeEpisodes(
              id: element['_id'],
              coverImage: element['coverImage'],
              episodeName: element['episodeName'],
              movieOwner: element['animeOwner'][0]['movieName']));
        });
        return newEpisodeArray;
      } else {
        return [];
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }
}
