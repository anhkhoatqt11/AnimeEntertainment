import 'package:anime_and_comic_entertainment/components/comic/ComicChapter.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:provider/provider.dart';
// ignore_for_file: prefer_const_constructors

class DetailComicPage extends StatefulWidget {
  final String comicId;

  const DetailComicPage({super.key, required this.comicId});

  @override
  State<DetailComicPage> createState() => _DetailComicPageState();
}

class _DetailComicPageState extends State<DetailComicPage> {
  late bool isLoading = false;
  late Comics comic = Comics();
  Future<Comics> getComicDetailById() async {
    var result = await ComicsApi.getComicDetailById(context, widget.comicId);
    return result;
  }

  @override
  void initState() {
    super.initState();
    getComicDetailById().then((value) => setState(() {
          comic = value;
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return comic.landspaceImage == null
        ? Scaffold(
            backgroundColor: const Color(0xFF141414),
            appBar: GFAppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: GFIconButton(
                splashColor: Colors.transparent,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                type: GFButtonType.transparent,
              ),
            ),
            body: const Center(
              child: GFLoader(type: GFLoaderType.circle),
            ),
          )
        : Scaffold(
            backgroundColor: const Color(0xFF141414),
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF141414),
            ),
            body: ListView(
              children: [
                Stack(children: [
                  Column(
                    children: [
                      Image.network(
                          width: double.infinity,
                          //height: 100,
                          comic.landspaceImage.toString()),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                  Positioned(
                    right: 10,
                    bottom: 0,
                    child: GradientSquareButton(
                      width: 165,
                      height: 50,
                      action: () {
                      Provider.of<NavigatorProvider>(context, listen: false)
                          .setShow(false);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComicChapterDetail(
                              comic: comic,
                              index: 0,
                            ),
                          ),
                        );
                      },
                      content: 'ĐỌC NGAY',
                      cornerRadius: 10,
                    ),
                  )
                ]),
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                        child: Text(
                          comic.comicName ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.bookOpenReader,
                                color: Colors.white,
                              ),
                              const Text(
                                'Lượt xem',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                comic.totalView.toString(),
                                style: const TextStyle(color: Colors.yellow),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidThumbsUp,
                                color: Colors.white,
                              ),
                              const Text(
                                'Lượt thích',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                comic.totalLike.toString(),
                                style: const TextStyle(color: Colors.yellow),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidFile,
                                color: Colors.white,
                              ),
                              const Text(
                                'Số chương',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                comic.chapterList!.length.toString(),
                                style: const TextStyle(color: Colors.yellow),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Tác giả: ${comic.author}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Họa sĩ: ${comic.artist}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Thể loại: ${comic.genreNames![0]['genreName'].toString()}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Nội dung bởi: ${comic.publisher}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Mô tả: ${comic.description}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent),
                                  child: const Text(
                                    'Danh sách chương',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 218, 113, 15)),
                                  ))
                            ],
                          ),
                          Container(
                              height: 3,
                              color: const Color.fromARGB(255, 218, 113, 15)),
                          Container(
                            color: Colors.black,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      '${comic.chapterList!.length.toString()} Chương',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${comic.newChapterTime}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: comic.chapterList!.length * 100,
                            child: Column(
                                children: List.generate(
                                    comic.chapterList!.length,
                                    (index) => ComicChapter(
                                        index: index, comic: comic))),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ));
  }
}
