// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/banner.dart';
import 'package:anime_and_comic_entertainment/model/watchingHistories.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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

  static getAnimeAlbumContent(
      BuildContext context, albumId, limit, page) async {
    var url = Uri.parse(
      "${baseUrl}getAnimeInAlbum?idAlbum=$albumId&limit=$limit&page=$page",
    );
    try {
      final res = await http.get(url);
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
              movieOwner: element['animeOwner'][0]['movieName'],
              movieOwnerId: element['animeOwner'][0]['_id']));
        });
        return newEpisodeArray;
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
        List<Animes> rankingArray = [];
        result.forEach((element) {
          rankingArray.add(Animes(
              id: element['_id']['movieOwnerId'][0],
              coverImage: element['_id']['coverImage'][0],
              movieName: element['_id']['movieName'][0],
              landspaceImage: element['_id']['landspaceImage'][0]));
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

  static getTopViewAnime(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getTopViewAnime",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<Animes> topArray = [];
        result.forEach((element) {
          topArray.add(Animes(
              id: element['_id']['movieOwnerId'][0],
              movieName: element['_id']['movieName'][0],
              totalView: element['totalView']));
        });
        return topArray;
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

  static getAnimeChapterById(BuildContext context, animeId, limit, page) async {
    var url = Uri.parse(
      "${baseUrl}getAnimeChapterById?animeId=$animeId&limit=$limit&page=$page",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<AnimeEpisodes> animeEpisode = [];
        result[0]['movieEpisodes'].forEach((element) {
          if (element.length > 0) {
            animeEpisode.add(AnimeEpisodes(
              id: element['_id'],
              coverImage: element['coverImage'],
              episodeName: element['episodeName'],
              views: element['views'],
            ));
          }
        });
        return animeEpisode;
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

  static getAnimeDetailById(BuildContext context, animeId) async {
    var url = Uri.parse(
      "${baseUrl}getAnimeDetailById?animeId=$animeId",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        Animes animeDetail = Animes(
          id: result[0]['_id'],
          coverImage: result[0]['coverImage'],
          landspaceImage: result[0]['landspaceImage'],
          movieName: result[0]['movieName'],
          genres: result[0]['genreNames'],
          publishTime: result[0]['publishTime'],
          ageFor: result[0]['ageFor'],
          publisher: result[0]['publisher'],
          description: result[0]['description'],
          episodes: result[0]['detailEpisodeList'],
          totalView: result[0]['totalViews'],
          totalLike: result[0]['totalLikes'],
        );
        return animeDetail;
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

  static getAnimeEpisodeDetailById(BuildContext context, episodeId) async {
    var url = Uri.parse(
      "${baseUrl}getAnimeEpisodeDetailById?episodeId=$episodeId",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        AnimeEpisodes episodeDetail = AnimeEpisodes(
            id: result[0]['_id'],
            advertising: result[0]['advertisementContent'][0]['adVideoUrl'],
            content: result[0]['content'],
            episodeName: result[0]['episodeName'],
            likes: result[0]['likes'],
            totalTime: result[0]['totalTime'],
            views: result[0]['views'],
            adLink: result[0]['advertisementContent'][0]['forwardLink'],
            comments: result[0]['comments']);

        return episodeDetail;
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

  static getSomeTopViewEpisodes(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getSomeTopViewEpisodes",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<AnimeEpisodes> animeEpisode = [];
        result.forEach((element) {
          animeEpisode.add(AnimeEpisodes(
              id: element['_id'],
              coverImage: element['coverImage'],
              episodeName: element['episodeName'],
              totalTime: element['totalTime'],
              views: element['views'],
              movieOwnerId: element['movieOwner'][0]['_id']));
        });
        return animeEpisode;
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

  static getAnimeDetailInEpisodePageById(BuildContext context, animeId) async {
    var url = Uri.parse(
      "${baseUrl}getAnimeDetailInEpisodePageById?animeId=$animeId",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        Animes animeDetail = Animes(
          id: result[0]['_id'],
          movieName: result[0]['movieName'],
          genres: result[0]['genreNames'],
          publishTime: result[0]['publishTime'],
          ageFor: result[0]['ageFor'],
          publisher: result[0]['publisher'],
          episodes: result[0]['listEpisodes'],
        );
        return animeDetail;
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

  static updateEpisodeView(BuildContext context, episodeId) async {
    var url = Uri.parse(
      "${baseUrl}updateEpisodeView",
    );
    try {
      var body = {
        "episodeId": episodeId,
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

  static updateUserLikeEpisode(BuildContext context, episodeId, userId) async {
    var url = Uri.parse(
      "${baseUrl}updateUserLikeEpisode",
    );
    try {
      var body = {"episodeId": episodeId, "userId": userId};
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

  static updateUserSaveEpisode(BuildContext context, episodeId, userId) async {
    var url = Uri.parse(
      "${baseUrl}updateUserSaveEpisode",
    );
    try {
      var body = {"episodeId": episodeId, "userId": userId};
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

  static checkUserHasLikeOrSaveEpisode(
      BuildContext context, episodeId, userId) async {
    var url = Uri.parse(
      "${baseUrl}checkUserHasLikeOrSaveEpisode?episodeId=$episodeId&userId=$userId",
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

  static getWatchingHistories(BuildContext context, userId, limit, page) async {
    var url = Uri.parse(
      "${baseUrl}getWatchingHistories?userId=$userId&limit=$limit&page=$page",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        var index = 0;
        List<WatchingHistories> histories = [];
        result[0]['detailHistories'].forEach((element) {
          histories.add(WatchingHistories(
              id: element['_id'],
              coverImage: element['coverImage'],
              episodeName: element['episodeName'],
              totalTime: element['totalTime'],
              position: result[0]['histories']['watchingMovie'][index]
                  ['position'],
              movieOwnerId: element['movieOwner'][0]['_id']));
          index++;
        });
        return histories;
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

  static checkUserHistoryHadSeenEpisode(
      BuildContext context, episodeId, userId) async {
    var url = Uri.parse(
      "${baseUrl}checkUserHistoryHadSeenEpisode?episodeId=$episodeId&userId=$userId",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        if (result['position'] != null) {
          return result['position'];
        }
        return 0;
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

  static updateUserHistoryHadSeenEpisode(
      BuildContext context, episodeId, userId, position) async {
    var url = Uri.parse(
      "${baseUrl}updateUserHistoryHadSeenEpisode",
    );
    try {
      var body = {
        "episodeId": episodeId,
        "userId": userId,
        "position": position
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

  static searchForAnimes(BuildContext context, searchWord) async {
    var url = Uri.parse("${baseUrl}searchAnimeAndEpisodes?query=$searchWord");
    print(url);
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        List<Animes> animeArray = [];
        result['animeResults'].forEach((element) {
          animeArray.add(Animes(
              id: element['_id'],
              coverImage: element['coverImage'],
              movieName: element['movieName']));
        });
        return animeArray;
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
}
