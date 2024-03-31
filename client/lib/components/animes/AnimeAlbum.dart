import 'package:anime_and_comic_entertainment/components/animes/AnimeItem.dart';
import 'package:anime_and_comic_entertainment/components/animes/EpisodeItem.dart';
import 'package:anime_and_comic_entertainment/components/animes/TopRankingAnime.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicItem.dart';
import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_album_page.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:shimmer/shimmer.dart';

class AnimeAlbumItem extends StatefulWidget {
  final dynamic animeId;
  const AnimeAlbumItem({super.key, required this.animeId});

  @override
  State<AnimeAlbumItem> createState() => _AnimeAlbumItemState();
}

class _AnimeAlbumItemState extends State<AnimeAlbumItem> {
  List<Animes> listAnimeItem = [];
  final controller = ScrollController();
  static const limit = 5;
  int page = 1;
  bool hasData = true;

  @override
  void initState() {
    fetch();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
    super.initState();
  }

  Future fetch() async {
    try {
      if (hasData == false) return;
      var newItems = await AnimesApi.getAnimeAlbumContent(
          context, widget.animeId, limit.toString(), page.toString());
      final isLastPage = newItems.length < limit;
      newItems.forEach((item) {
        setState(() {
          listAnimeItem.add(Animes(
              id: item.id,
              coverImage: item.coverImage,
              movieName: item.movieName));
        });
      });
      if (isLastPage) {
        setState(() {
          hasData = false;
        });
      } else {
        setState(() {
          page++;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemCount: listAnimeItem.length + 1,
        itemBuilder: (context, index) {
          if (index < listAnimeItem.length) {
            final item = listAnimeItem[index];
            return AnimeItem(
                urlImage: item.coverImage, nameItem: item.movieName);
          } else {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: hasData == true
                    ? const Center(
                        child: GFLoader(type: GFLoaderType.circle),
                      )
                    : null);
          }
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimeAlbumComponent extends StatefulWidget {
  const AnimeAlbumComponent({super.key});

  @override
  State<AnimeAlbumComponent> createState() => _AnimeAlbumComponentState();
}

class _AnimeAlbumComponentState extends State<AnimeAlbumComponent> {
  List<AnimeAlbum> listAlbum = [];
  List<Animes> listTopView = [];
  Future<List<AnimeAlbum>> getAllAlbum() async {
    var result = await AnimesApi.getAnimeAlbum(context);
    return result;
  }

  Future<List<Animes>> getTopViewAnime() async {
    var result = await AnimesApi.getTopViewAnime(context);
    return result;
  }

  @override
  void initState() {
    super.initState();
    getAllAlbum().then((value) => value.forEach((element) {
          setState(() {
            listAlbum.add(AnimeAlbum(
                id: element.id,
                albumName: element.albumName,
                animeList: element.animeList));
          });
        }));
    getTopViewAnime().then((value) => value.forEach((element) {
          setState(() {
            listTopView.add(Animes(
                id: element.id,
                movieName: element.movieName,
                totalView: element.totalView));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return listAlbum.isEmpty
        ? SizedBox(
            height: 256,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 125,
                        height: 187,
                        color: Colors.blue,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 125,
                        height: 187,
                        color: Colors.blue,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 125,
                        height: 187,
                        color: Colors.blue,
                      )),
                ),
              ],
            ),
          )
        : Column(
            children: List.generate(
                listAlbum.length > listTopView.length
                    ? listAlbum.length
                    : listTopView.length, (index) {
            return Column(
              children: [
                index < listAlbum.length
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => ComicAlbumPage(
                                  //             comicIdList: listAlbum[index].comicList,
                                  //             albumName: listAlbum[index].albumName,
                                  //           )),
                                  // );
                                },
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        listAlbum[index].albumName!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.chevronRight,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                              height: 256,
                              child:
                                  AnimeAlbumItem(animeId: listAlbum[index].id))
                        ],
                      )
                    : Container(),
                index < listTopView.length
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => ComicAlbumPage(
                                  //             comicIdList: listAlbum[index].comicList,
                                  //             albumName: listAlbum[index].albumName,
                                  //           )),
                                  // );
                                },
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        listTopView[index].movieName!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            height: 1,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.chevronRight,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                              height: 180,
                              child: TopViewEpisodeList(
                                  animeId: listTopView[index].id))
                        ],
                      )
                    : Container(),
                index == 4
                    ? const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              "️🏆 Bảng xếp hạng",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child:
                                SizedBox(height: 300, child: TopRankingAnime()),
                          ),
                        ],
                      )
                    : Container()
              ],
            );
          }));
  }
}

class TopViewEpisodeList extends StatefulWidget {
  final dynamic animeId;
  const TopViewEpisodeList({super.key, required this.animeId});

  @override
  State<TopViewEpisodeList> createState() => _TopViewEpisodeListState();
}

class _TopViewEpisodeListState extends State<TopViewEpisodeList> {
  List<AnimeEpisodes> listAnimeEpisodeItem = [];
  final controller = ScrollController();
  static const limit = 5;
  int page = 1;
  bool hasData = true;

  @override
  void initState() {
    fetch();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
    super.initState();
  }

  Future fetch() async {
    try {
      if (hasData == false) return;
      var newItems = await AnimesApi.getAnimeChapterById(
          context, widget.animeId, limit.toString(), page.toString());
      final isLastPage = newItems.length < limit;
      newItems.forEach((item) {
        setState(() {
          listAnimeEpisodeItem.add(AnimeEpisodes(
              id: item.id,
              coverImage: item.coverImage,
              episodeName: item.episodeName,
              views: item.views));
        });
      });
      if (isLastPage) {
        setState(() {
          hasData = false;
        });
      } else {
        setState(() {
          page++;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemCount: listAnimeEpisodeItem.length + 1,
        itemBuilder: (context, index) {
          if (index < listAnimeEpisodeItem.length) {
            final item = listAnimeEpisodeItem[index];
            return EpisodeItem(
              urlImage: item.coverImage,
              nameItem: item.episodeName,
              views: item.views,
            );
          } else {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: hasData == true
                    ? const Center(
                        child: GFLoader(type: GFLoaderType.circle),
                      )
                    : null);
          }
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
