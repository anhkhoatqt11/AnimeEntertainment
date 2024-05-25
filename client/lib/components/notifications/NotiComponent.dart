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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
                    BoxShadow(color: Color.fromARGB(255, 66, 71, 66)),
                  ],
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: comic.landspaceImage!,
                      height: 70,
                      width: 110,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
                      child: Center(
                          child: Text(
                        noti.content!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )),
                    ),
                  ],
                )),
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
            child: Container(
                height: 75,
                width: MediaQuery.of(context).size.width - 10,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Color.fromARGB(255, 66, 71, 66)),
                  ],
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: anime.landspaceImage!,
                      height: 70,
                      width: 110,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 130,
                      child: Center(
                          child: Text(
                        noti.content!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )),
                    ),
                  ],
                )),
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
                  BoxShadow(color: Color.fromARGB(255, 66, 71, 66)),
                ],
              ),
              child: Center(
                  child: Text(
                noti.content!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ))),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComicChapterComment(
                chapterId: noti.sourceId!,
              ),
            ));
      },
    );
  }
}
