import 'package:anime_and_comic_entertainment/components/animes/AnimeAlbum.dart';
import 'package:anime_and_comic_entertainment/components/animes/TopRankingAnime.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicAlbum.dart';
import 'package:anime_and_comic_entertainment/components/comic/TopRankingComic.dart';
import 'package:anime_and_comic_entertainment/components/donate/DonatePackageListHome.dart';
import 'package:anime_and_comic_entertainment/components/ui/DonateBannerHome.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/pages/anime/anime_album_page.dart';
import 'package:anime_and_comic_entertainment/pages/anime/top_view_detail_page.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_album_page.dart';
import 'package:anime_and_comic_entertainment/pages/donate/donate_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:flutter/material.dart';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeAlbumComponent extends StatefulWidget {
  const HomeAlbumComponent({super.key});

  @override
  State<HomeAlbumComponent> createState() => _HomeAlbumComponentState();
}

class _HomeAlbumComponentState extends State<HomeAlbumComponent> {
  List<ComicAlbum> listComicAlbum = [];
  Future<List<ComicAlbum>> getAllComicAlbum() async {
    var result = await ComicsApi.getComicAlbum(context);
    return result;
  }

  List<AnimeAlbum> listAnimeAlbum = [];
  List<Animes> listTopView = [];
  Future<List<AnimeAlbum>> getAllAnimeAlbum() async {
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
    getAllComicAlbum().then((value) => value.forEach((element) {
          setState(() {
            listComicAlbum.add(ComicAlbum(
                id: element.id,
                albumName: element.albumName,
                comicList: element.comicList));
          });
        }));
    getAllAnimeAlbum().then((value) => value.forEach((element) {
          setState(() {
            listAnimeAlbum.add(AnimeAlbum(
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
    return listComicAlbum.isEmpty || listAnimeAlbum.isEmpty
        ? SizedBox(
            height: 193,
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
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
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
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
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
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                      )),
                ),
              ],
            ),
          )
        : Column(
            children: List.generate(
                (listAnimeAlbum.length / 2).round() >
                        (listTopView.length / 2).round()
                    ? ((listAnimeAlbum.length / 2).round() >
                            listComicAlbum.length
                        ? (listAnimeAlbum.length / 2).round()
                        : listComicAlbum.length)
                    : ((listTopView.length / 2).round() > listComicAlbum.length
                        ? (listTopView.length / 2).round()
                        : listComicAlbum.length), (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                index < listComicAlbum.length
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ComicAlbumPage(
                                              comicIdList: listComicAlbum[index]
                                                  .comicList,
                                              albumName: listComicAlbum[index]
                                                  .albumName,
                                            )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        listComicAlbum[index].albumName!,
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
                              child: ComicAlbumItem(
                                  idList: listComicAlbum[index]
                                      .comicList
                                      .toString()))
                        ],
                      )
                    : Container(),
                2 * index < listAnimeAlbum.length
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AnimeAlbumPage(
                                              albumId:
                                                  listAnimeAlbum[2 * index].id,
                                              albumName:
                                                  listAnimeAlbum[2 * index]
                                                      .albumName,
                                            )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        listAnimeAlbum[2 * index].albumName!,
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
                              child: AnimeAlbumItem(
                                  animeId: listAnimeAlbum[2 * index].id))
                        ],
                      )
                    : Container(),
                2 * index + 1 < listAnimeAlbum.length
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AnimeAlbumPage(
                                              albumId:
                                                  listAnimeAlbum[2 * index + 1]
                                                      .id,
                                              albumName:
                                                  listAnimeAlbum[2 * index + 1]
                                                      .albumName,
                                            )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        listAnimeAlbum[2 * index + 1]
                                            .albumName!,
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
                              child: AnimeAlbumItem(
                                  animeId: listAnimeAlbum[2 * index + 1].id))
                        ],
                      )
                    : Container(),
                index * 2 < listTopView.length
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TopViewDetailPage(
                                              animeId:
                                                  listTopView[index * 2].id,
                                              movieName: listTopView[index * 2]
                                                  .movieName,
                                            )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        listTopView[index * 2].movieName!,
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
                                  animeId: listTopView[index * 2].id))
                        ],
                      )
                    : Container(),
                index * 2 + 1 < listTopView.length
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TopViewDetailPage(
                                              animeId:
                                                  listTopView[index * 2 + 1].id,
                                              movieName:
                                                  listTopView[index * 2 + 1]
                                                      .movieName,
                                            )),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        listTopView[index * 2 + 1].movieName!,
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
                                  animeId: listTopView[index * 2 + 1].id))
                        ],
                      )
                    : Container(),
                index == 1
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DonatePage()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DonateBannerHome(
                            urlAsset: 'assets/images/donate1.png',
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                index == 2
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DonatePage()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DonateBannerHome(
                            urlAsset: 'assets/images/donate2.png',
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                index == 2
                    ? const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              "️🔥 Donate ủng hộ chúng mình nè",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: SizedBox(
                                height: 250, child: DonatePackageListHome()),
                          ),
                        ],
                      )
                    : Container(),
                index == 3
                    ? const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              "️🔥 Donate ủng hộ chúng mình nè",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: SizedBox(
                                height: 250, child: DonatePackageListHome()),
                          ),
                        ],
                      )
                    : Container(),
                index == 4
                    ? const Padding(
                        padding: EdgeInsets.fromLTRB(3, 10, 0, 10),
                        child: TopRankingComic(),
                      )
                    : Container(),
              ],
            );
          }));
  }
}
