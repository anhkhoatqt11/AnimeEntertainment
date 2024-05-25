import 'package:anime_and_comic_entertainment/components/animes/AnimeAlbumItem.dart';
import 'package:anime_and_comic_entertainment/components/animes/AnimeItem.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicItem.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicLandspaceItem.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/anime/detail_anime_page.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
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
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GFIconButton(
                size: GFSize.SMALL,
                splashColor: Colors.transparent,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () {
                  Navigator.pop((context));
                },
                type: GFButtonType.transparent,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 20,
                    ),
                    hintText: "Tìm kiếm phim, anime, comic, diễn viên, ...",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  readOnly: true,
                  onTap: () {
                    Navigator.pop((context));
                  },
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Utils.primaryColor,
            dividerColor: Colors.transparent,
            labelColor: Utils.primaryColor,
            tabs: const [
              Tab(
                text: "      Anime      ",
              ),
              Tab(
                text: "      Truyện      ",
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TabBarView(children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Anime (${listAnimeItem.length} kết quả)",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
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
                                          animeId: listAnimeItem[index].id,
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
                      "Truyện (${listComicItem.length} kết quả)",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
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
