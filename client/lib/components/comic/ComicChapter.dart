import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: comic.chapterList![widget.index]['coverImage'],
            width: 100,
            height: 90,
          ),
          const SizedBox(
            width: 10,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(
                  publishTime,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
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
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
            child: Text(
              comic.chapterList![widget.index]['unlockPrice'] > 0
                  ? comic.chapterList![widget.index]['unlockPrice']
                  : "Miễn phí",
              style: const TextStyle(fontSize: 16, color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
