import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/model/comicchapters.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/model/notification.dart';
import 'package:anime_and_comic_entertainment/pages/anime/detail_anime_page.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_comment.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_detail.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/services/user_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotiComponent extends StatefulWidget {
  final Notifications noti;
  final int index;

  const NotiComponent({super.key, required this.noti, required this.index});

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
    return GestureDetector(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Row(
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
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: noti.type == "chapter" &&
                              comic.landspaceImage != null
                          ? comic.landspaceImage!
                          : noti.type == "episode" &&
                                  anime.landspaceImage != null
                              ? anime.landspaceImage!
                              : 'https://cdn-icons-png.flaticon.com/512/4387/4387152.png',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          noti.content!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.clock,
                              size: 12,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              sentTime,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: .5,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
      onTap: () {
        if (noti.status == "sent") {
          UsersApi.readNotication(context, widget.index);
          Provider.of<UserProvider>(context, listen: false)
              .setNotificationSentCount(-1);
        }

        if (noti.type == "chapter") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailComicPage(
                  comicId: comic.id!,
                ),
              ));
        } else if (noti.type == "episode") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailAnimePage(
                  animeId: anime.id!,
                ),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComicChapterComment(
                    sourceId: noti.sourceId!,
                    type:
                        noti.type == "commentChapter" ? "chapter" : "episode"),
              ));
        }
      },
    );
  }
}
