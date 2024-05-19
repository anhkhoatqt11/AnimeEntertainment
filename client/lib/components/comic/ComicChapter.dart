import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ComicChapter extends StatefulWidget {
  final int index;
  final Comics comic;

  const ComicChapter({super.key, required this.index, required this.comic});

  @override
  State<ComicChapter> createState() => _ComicChapterState();
}

class _ComicChapterState extends State<ComicChapter> {
  @override
  Widget build(BuildContext context) {
    Comics comic = widget.comic;
    DateTime date = DateFormat('yyyy-MM-dd')
        .parse(comic.chapterList![widget.index]['publicTime']);
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    String publishTime = dateFormat.format(date);

    return GestureDetector(
      onTap: () {
        Provider.of<NavigatorProvider>(context, listen: false).setShow(false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComicChapterDetail(
              comic: comic,
              index: widget.index,
            ),
          ),
        );
      },
      child: SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: comic.chapterList![widget.index]['coverImage'],
                  width: 60,
                  height: 60,
                  placeholder: (context, url) => Container(
                    width: 100,
                    color: Colors.blue,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 100,
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
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(comic.chapterList![widget.index]['chapterName'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        publishTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                comic.chapterList![widget.index]['unlockPrice'] > 0
                    ? Container(
                        height: 40,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color.fromARGB(255, 27, 27, 27)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              comic.chapterList![widget.index]['unlockPrice']
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Utils.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/images/skycoin.png",
                              width: 16,
                              height: 16,
                            ),
                          ],
                        ))
                    : Container(
                        height: 40,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.transparent),
                        child: Text(
                          "Miễn phí",
                          style: TextStyle(
                              fontSize: 14,
                              color: Utils.primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Divider(
              color: Colors.grey[800],
              thickness: .5,
            )
          ],
        ),
      ),
    );
  }
}
