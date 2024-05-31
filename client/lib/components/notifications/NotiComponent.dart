import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/comicchapters.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/model/notification.dart';
import 'package:anime_and_comic_entertainment/pages/anime/detail_anime_page.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_comment.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_detail.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class NotiComponent extends StatefulWidget {
  final Notifications noti;

  const NotiComponent({super.key, required this.noti});

  @override
  State<NotiComponent> createState() => _ComicChapterState();
}

class _ComicChapterState extends State<NotiComponent> {
  late Comics comic = Comics();
  late Animes anime = Animes();
  Future<Comics> getComic(String id) async {
    var result = await ComicsApi.getComicDetailById(context, id);
    return result;
  }

  Future<Animes> getAnime(String id) async {
    var result = await AnimesApi.getAnimeDetailById(context, id);
    return result;
  }

  @override
  void initState() {
    super.initState();
    if (widget.noti.type == "chapter") {
      getComic(widget.noti.sourceId!).then((value) {
        setState(() {
          comic = value;
        });
      });
    }

    if (widget.noti.type == "episode") {
      getAnime(widget.noti.sourceId!).then((value) {
        setState(() {
          anime = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Notifications noti = widget.noti;
    DateTime date = DateFormat('yyyy-MM-dd').parse(noti.sentTime!);
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String sentTime = dateFormat.format(date);

    if (noti.type == "chapter" && comic.landspaceImage != null) {
      return GestureDetector(
        child: SizedBox(
          height: 85,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Container(
              height: 75,
              width: MediaQuery.of(context).size.width - 10,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Color(0xFF141414)),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 10,
                          width: 10,
                          color: noti.status == 'sent'
                              ? Utils.primaryColor
                              : Colors.transparent,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: comic.landspaceImage!,
                          height: 70,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 130,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 130,
                              child: Text(
                                noti.content!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 130,
                              child: Text(
                                sentTime,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    color: Colors.white,
                    height: 1,
                    width: MediaQuery.of(context).size.width - 10,
                  )
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailComicPage(
                  comicId: comic.id!,
                ),
              ));
        },
      );
    }

    if (noti.type == "episode" && anime.landspaceImage != null) {
      return GestureDetector(
        child: SizedBox(
          height: 85,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Column(
              children: [
                Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Color(0xFF141414)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 10,
                              width: 10,
                              color: noti.status == 'sent'
                                  ? Utils.primaryColor
                                  : Colors.transparent,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: anime.landspaceImage!,
                              height: 70,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 130,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width - 130,
                                  child: Text(
                                    noti.content!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 130,
                                  child: Text(
                                    sentTime,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        color: Colors.white,
                        height: 1,
                        width: MediaQuery.of(context).size.width - 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailAnimePage(
                  animeId: anime.id!,
                ),
              ));
        },
      );
    }

    return GestureDetector(
      child: SizedBox(
        height: 85,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Container(
            height: 75,
            width: MediaQuery.of(context).size.width - 10,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(color: Color(0xFF141414)),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 10,
                        width: 10,
                        color: noti.status == 'sent'
                            ? Utils.primaryColor
                            : Colors.transparent,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://cdn-icons-png.flaticon.com/512/4387/4387152.png',
                        height: 70,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 130,
                            child: Text(
                              noti.content!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 130,
                            child: Text(
                              sentTime,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  color: Colors.white,
                  height: 1,
                  width: MediaQuery.of(context).size.width - 10,
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComicChapterComment(
                  sourceId: noti.sourceId!,
                  type: noti.type == "commentChapter" ? "chapter" : "episode"),
            ));
      },
    );
  }
}
