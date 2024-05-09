// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/model/banner.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/model/comment.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ComicsApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/comics/";

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

  static getComicAlbumContent(BuildContext context, idList, limit, page) async {
    var url = Uri.parse(
      "${baseUrl}getComicInAlbum?idList=$idList&limit=$limit&page=$page",
    );
    try {
      final res = await http.get(url);
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

  static searchForComics(BuildContext context, searchWord) async {
    var url = Uri.parse("${baseUrl}searchComic?query=$searchWord");
    print(url);
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<Comics> searchArray = [];
        result.forEach((element) {
          searchArray.add(Comics(
              id: element['_id'],
              coverImage: element['coverImage'],
              comicName: element['comicName'],
              landspaceImage: element['landspaceImage'],
              genres: element['genres']));
        });
        return searchArray;
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

  static getComicDetailById(BuildContext context, String comicId) async {
    var url = Uri.parse(
      "${baseUrl}getDetailComicById?comicId=$comicId",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        Comics comicDetail = Comics(
          id: result[0]['_id'],
          coverImage: result[0]['coverImage'],
          landspaceImage: result[0]['landspaceImage'],
          comicName: result[0]['comicName'],
          author: result[0]['author'],
          artist: result[0]['artist'],
          genres: result[0]['genreNames'],
          newChapterTime: result[0]['newChapterTime'],
          ageFor: result[0]['ageFor'],
          publisher: result[0]['publisher'],
          description: result[0]['description'],
          chapterList: result[0]['detailChapterList'],
          genreNames: result[0]['genreNames'],
          totalView: result[0]['totalViews'],
          totalLike: result[0]['totalLikes'],
        );
        return comicDetail;
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

  static updateUserSaveChapter(BuildContext context, chapterId, userId) async {
    var url = Uri.parse(
      "${baseUrl}updateUserSaveChapter",
    );
    try {
      var body = {"chapterId": chapterId, "userId": userId};
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

  static checkUserHasLikeOrSaveChapter(
      BuildContext context, chapterId, userId) async {
    var url = Uri.parse(
      "${baseUrl}checkUserHasLikeOrSaveChapter?chapterId=$chapterId&userId=$userId",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        return result;
      } else {
        return {};
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

  static updateChapterView(BuildContext context, chapterId) async {
    var url = Uri.parse(
      "${baseUrl}updateChapterView",
    );
    try {
      var body = {
        "chapterId": chapterId,
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

  static updateUserLikeChapter(BuildContext context, chapterId, userId) async {
    var url = Uri.parse(
      "${baseUrl}updateUserLikeChapter",
    );
    try {
      var body = {"chapterId": chapterId, "userId": userId};
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

  static updateUserHistoryHadSeenChapter(
      BuildContext context, chapterId, userId) async {
    var url = Uri.parse(
      "${baseUrl}updateUserHistoryHadSeenChapter",
    );
    try {
      var body = {"chapterId": chapterId, "userId": userId};
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

  static getComicChapterComments(BuildContext context, chapterId) async {
    var url =
        Uri.parse("${baseUrl}getComicChapterComments?chapterId=$chapterId");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<Comments> comments = [];

        result.forEach((element) {
          comments.add(Comments(
              userId: element['userId'],
              likes: element['likes'],
              replies: element['replies'],
              content: element['content'],
              userName: element['userName'],
              avatar: element['avatar']));
        });

        return comments;
      } else {
        return {};
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
