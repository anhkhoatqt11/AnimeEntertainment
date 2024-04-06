// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/model/banner.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComicsApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/comics/";

  // static getComic(id) async {
  //   var url = Uri.parse(
  //     "${baseUrl}getComic/$id",
  //   );
  //   try {
  //     final res = await http.get(url);
  //     print(jsonDecode(res.body));
  //     if (res.statusCode == 200) {
  //       var data = jsonDecode(res.body);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static getComics() async {
  //   List<Comics> comics = [];
  //   var url = Uri.parse(
  //     "${baseUrl}getAllComics",
  //   );
  //   try {
  //     final res = await http.get(url);
  //     print(jsonDecode(res.body));
  //     if (res.statusCode == 200) {
  //       var data = jsonDecode(res.body);
  //       data.forEach((value) => {
  //             comics.add(Comics(
  //               coverImage: value['coverImage'],
  //               comicName: value['comicName'],
  //               author: value['author'],
  //               artist: value['artist'],
  //               genres: value['genres'],
  //               ageFor: value['ageFor'],
  //               publisher: value['publisher'],
  //               description: value['description'],
  //               newChapterTime: value['newChapterTime'],
  //               chapterList: value['chapterList'],
  //             ))
  //           });
  //       return comics;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // static getChapterComic(id) async {
  //   var url = Uri.parse(
  //     "${baseUrl}getChapterComic/$id",
  //   );
  //   try {
  //     final res = await http.get(url);
  //     print(jsonDecode(res.body));
  //     if (res.statusCode == 200) {
  //       var data = jsonDecode(res.body);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  static getComicBanners(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getComicBanner",
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

  static getNewChapterComic(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getNewChapterComic",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<Comics> newChapterArray = [];
        result.forEach((element) {
          newChapterArray.add(Comics(
              id: element['_id']['chapterOwnerId'][0],
              coverImage: element['_id']['coverImage'][0],
              comicName: element['_id']['comicName'][0],
              genres: element['_id']['genres']));
        });
        return newChapterArray;
      } else {
        return [];
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static getComicAlbum(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getComicAlbum",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<ComicAlbum> comicAlbumArray = [];
        result.forEach((element) {
          comicAlbumArray.add(ComicAlbum(
              id: element['_id'],
              albumName: element['albumName'],
              comicList: element['comicList']));
        });
        return comicAlbumArray;
      } else {
        return [];
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static getComicAlbumContent(BuildContext context, idList, limit, page) async {
    var url = Uri.parse(
      "${baseUrl}getComicInAlbum",
    );
    try {
      var body = {
        "idList": idList,
        "limit": limit,
        "page": page,
      };
      final res = await http.post(url, body: body);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<Comics> comicAlbumItemArray = [];
        result.forEach((element) {
          if (element.length > 0) {
            comicAlbumItemArray.add(Comics(
                id: element[0]['_id'],
                comicName: element[0]['comicName'],
                coverImage: element[0]['coverImage'],
                genres: element[0]['genreName'],
                description: element[0]['description']));
          }
        });
        return comicAlbumItemArray;
      } else {
        return [];
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }

  static getRankingTable(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getRankingTable",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<Comics> rankingArray = [];
        result.forEach((element) {
          rankingArray.add(Comics(
              id: element['_id']['comicOwnerId'][0],
              coverImage: element['_id']['coverImage'][0],
              comicName: element['_id']['comicName'][0],
              landspaceImage: element['_id']['landspaceImage'][0],
              genres: element['_id']['genres']));
        });
        return rankingArray;
      } else {
        return [];
      }
    } catch (e) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NoInternetPage()));
    }
  }
}
