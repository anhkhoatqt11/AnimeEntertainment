import 'package:anime_and_comic_entertainment/components/animes/AnimeItem.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicItem.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/anime/detail_anime_page.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key, required this.searchWord});
  final String searchWord;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List<Animes> listAnimeItem = [];
  List<Comics> listComicItem = [];
  late final TextEditingController textController;
  final controller = ScrollController();
  int page = 1;
  bool hasData = true;

  @override
  void initState() {
    fetch();
    // controller.addListener(() {
    //   if (controller.position.maxScrollExtent == controller.offset) {
    //     fetch();
    //   }
    // });
    textController = TextEditingController(text: widget.searchWord);

    super.initState();
  }

  Future fetch() async {
    try {
      if (hasData == false) return;
      var items = await AnimesApi.searchForAnimes(context, widget.searchWord);
      items.forEach((item) {
        setState(() {
          listAnimeItem.add(Animes(
            id: item.id,
            coverImage: item.coverImage,
            movieName: item.movieName,
          ));
        });
      });
      var comicItems =
          await ComicsApi.searchForComics(context, widget.searchWord);
      comicItems.forEach((item) {
        setState(() {
          listComicItem.add(Comics(
            id: item.id,
            coverImage: item.coverImage,
            comicName: item.comicName,
            genres: item.genres,
          ));
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: GFAppBar(
          backgroundColor: const Color(0xFF141414),
          elevation: 0,
          title: TextField(
            controller: textController,
            decoration: InputDecoration(
              // hintText: "Tìm kiếm phim, anime, comic, diễn viên, ...",
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
            readOnly: true,
            onTap: () {
              Navigator.pop((context));
            },
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Anime",
              ),
              Tab(
                text: "Truyện",
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(0.0),
          child: TabBarView(children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "ANIME (${listAnimeItem.length} KẾT QUẢ)",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                    fit: FlexFit.tight,
                    child: ListView(
                        controller: controller,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: List.generate(listAnimeItem.length,
                                      (index) {
                                    if (index < listAnimeItem.length) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: AnimeItem(
                                          urlImage:
                                              listAnimeItem[index].coverImage,
                                          nameItem:
                                              listAnimeItem[index].movieName,
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 32),
                                          child: hasData == true
                                              ? const Center(
                                                  child: GFLoader(
                                                      type:
                                                          GFLoaderType.circle),
                                                )
                                              : null);
                                    }
                                  })))
                        ]))
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "TRUYỆN (${listComicItem.length} KẾT QUẢ)",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                    fit: FlexFit.tight,
                    child: ListView(
                        controller: controller,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: List.generate(listComicItem.length,
                                      (index) {
                                    if (index < listComicItem.length) {
                                      return InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         DetailComicPage(
                                          //       animeId:
                                          //           listComicItem[index].id,
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: ComicItem(
                                          comicId: listComicItem[index].id,
                                          urlImage:
                                              listComicItem[index].coverImage,
                                          nameItem:
                                              listComicItem[index].comicName,
                                          genres: [],
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 32),
                                          child: hasData == true
                                              ? const Center(
                                                  child: GFLoader(
                                                      type:
                                                          GFLoaderType.circle),
                                                )
                                              : null);
                                    }
                                  })))
                        ]))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
