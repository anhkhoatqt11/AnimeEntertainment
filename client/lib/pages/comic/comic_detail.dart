import 'package:anime_and_comic_entertainment/components/comic/ComicChapter.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_buy_chapter.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_genre_result_page.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
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
  bool isExpanded = false;
  String textExpander = "Xem thêm";
  Future<Comics> getComicDetailById() async {
    var result = await ComicsApi.getComicDetailById(context, widget.comicId);
    return result;
  }

  @override
  void initState() {
    super.initState();
    FirebaseApi().listenEvent(context);
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
            body: const Center(
              child: GFLoader(type: GFLoaderType.circle),
            ),
          )
        : Scaffold(
            backgroundColor: const Color(0xFF141414),
            body: ListView(
              children: [
                Stack(children: [
                  Column(
                    children: [
                      FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loadingcomicimage.png',
                          image: comic.landspaceImage.toString(),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 9 / 16,
                          fit: BoxFit.cover),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(102, 56, 56, 56),
                      child: GFIconButton(
                          splashColor: Colors.transparent,
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          type: GFButtonType.transparent),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 0,
                    child: GradientSquareButton(
                      width: 165,
                      height: 50,
                      action: () {
                        if (comic.chapterList![0]['unlockPrice'] > 0) {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) {
                                return ComicBuyChapter(
                                  comic: comic,
                                  index: 0,
                                );
                              },
                            ),
                          );
                          return;
                        }
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
                      content: '📖 ĐỌC NGAY',
                      cornerRadius: 16,
                    ),
                  )
                ]),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 15),
                        child: Text(
                          comic.comicName ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 110,
                            child: Column(children: [
                              const FaIcon(
                                FontAwesomeIcons.solidThumbsUp,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Wrap(
                                children: [
                                  ShaderMask(
                                    shaderCallback: (rect) => LinearGradient(
                                      colors: Utils.gradientColors,
                                      begin: Alignment.topCenter,
                                    ).createShader(rect),
                                    child: Text(
                                      comic.totalLike!.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ),
                                  const Text(
                                    " lượt thích",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  )
                                ],
                              )
                            ]),
                          ),
                          SizedBox(
                            width: 110,
                            child: Column(children: [
                              const FaIcon(
                                FontAwesomeIcons.solidEye,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Wrap(
                                children: [
                                  ShaderMask(
                                    shaderCallback: (rect) => LinearGradient(
                                      colors: Utils.gradientColors,
                                      begin: Alignment.topCenter,
                                    ).createShader(rect),
                                    child: Text(
                                      Utils.formatNumberWithDots(
                                          comic.totalView!),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ),
                                  const Text(
                                    " lượt đọc",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  )
                                ],
                              )
                            ]),
                          ),
                          SizedBox(
                            width: 110,
                            child: Column(children: [
                              const FaIcon(
                                FontAwesomeIcons.clipboardList,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Wrap(
                                children: [
                                  ShaderMask(
                                    shaderCallback: (rect) => LinearGradient(
                                      colors: Utils.gradientColors,
                                      begin: Alignment.topCenter,
                                    ).createShader(rect),
                                    child: Text(
                                      comic.chapterList!.length.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ),
                                  const Text(
                                    " chương",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  )
                                ],
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Tác giả: ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Flexible(
                                child: Text(comic.author!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey[350],
                                        fontWeight: FontWeight.w500)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Họa sĩ: ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Flexible(
                                child: Text(comic.artist!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Thể loại: ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Expanded(
                                child: Wrap(
                                    spacing: 2,
                                    children: List.generate(
                                      comic.genreNames!.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchGenreResultPage(
                                                genreId: comic
                                                    .genreNames![index]['_id'],
                                                genreName:
                                                    comic.genreNames![index]
                                                        ['genreName'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                            comic.genreNames![index]
                                                    ['genreName'] +
                                                (index ==
                                                        comic.genreNames!
                                                                .length -
                                                            1
                                                    ? ""
                                                    : ", "),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Utils.primaryColor,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Nội dung bởi: ",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Flexible(
                                child: Text(comic.publisher!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          isExpanded
                              ? Text(
                                  comic.description!,
                                  style: const TextStyle(color: Colors.white),
                                )
                              : Container(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                                textExpander =
                                    isExpanded ? "Rút gọn" : "Xem thêm";
                              });
                            },
                            child: Text(
                              textExpander,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500,
                                decorationThickness: 2,
                                decorationColor: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                            child: Text(
                              'Danh sách chương',
                              style: TextStyle(color: Utils.primaryColor),
                            ),
                          ),
                          ShaderMask(
                              shaderCallback: (rect) => LinearGradient(
                                    colors: Utils.gradientColors,
                                    begin: Alignment.topCenter,
                                  ).createShader(rect),
                              child: Container(height: 3, color: Colors.white)),
                          Container(
                            color: Colors.transparent,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
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
                                    (index) => ComicChapterComponent(
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
