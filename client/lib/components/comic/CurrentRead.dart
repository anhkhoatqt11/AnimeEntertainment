import 'package:anime_and_comic_entertainment/model/comicchapters.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_detail.dart';
import 'package:anime_and_comic_entertainment/providers/comic_detail_provider.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class CurrentRead extends StatelessWidget {
  final String urlImage;
  final String nameItem;
  final Comics comic;
  final String chapterId;
  const CurrentRead(
      {super.key,
      required this.urlImage,
      required this.nameItem,
      required this.comic,
      required this.chapterId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: 125,
        child: Column(children: [
          GestureDetector(
            onTap: () {
              Provider.of<NavigatorProvider>(context, listen: false)
                  .setShow(false);
              Provider.of<ComicChapterProvider>(context, listen: false)
                  .setComic(Comics(id: comic.id), ComicChapter(id: chapterId));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComicChapterDetail(
                    comic: comic,
                    index: comic.chapterList!
                        .indexWhere((o) => o['_id'] == chapterId),
                  ),
                ),
              );
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CachedNetworkImage(
                  imageUrl: urlImage,
                  width: 125,
                  height: 125,
                  placeholder: (context, url) => Container(
                    height: 125,
                    width: 125,
                    color: Colors.blue,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 125,
                        height: 125,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill)),
                    );
                  },
                ),
                Opacity(
                  opacity: 0.6,
                  child: Container(
                    width: 125,
                    height: 125,
                    color: Colors.black,
                  ),
                ),
                const FaIcon(
                  FontAwesomeIcons.readme,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Provider.of<NavigatorProvider>(context, listen: false)
                        .setShow(false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComicChapterDetail(
                          comic: comic,
                          index: comic.chapterList!
                              .indexWhere((o) => o['_id'] == chapterId),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    nameItem,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailComicPage(comicId: comic.id!)),
                  );
                },
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
