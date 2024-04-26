import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ComicChapter extends StatefulWidget {
  final String coverImage;
  final String chapterName;
  final int unlockPrice;
  final String publicTime;

  const ComicChapter(
      {super.key,
      required this.coverImage,
      required this.chapterName,
      required this.unlockPrice,
      required this.publicTime});

  @override
  State<ComicChapter> createState() => _ComicChapterState();
}

class _ComicChapterState extends State<ComicChapter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: widget.coverImage,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.chapterName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(
                  widget.publicTime.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.unlockPrice > 0 ? widget.unlockPrice.toString() : "Miễn phí",
            style: const TextStyle(fontSize: 16, color: Colors.orange),
          )
        ],
      ),
    );
  }
}
