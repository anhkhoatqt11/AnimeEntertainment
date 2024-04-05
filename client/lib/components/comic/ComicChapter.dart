import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ComicChapter extends StatefulWidget {
  const ComicChapter({super.key});

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
            imageUrl:
                "https://i.guim.co.uk/img/media/2281074279af96115bbfdfa2f64dfc1eab685d69/0_0_3000_2318/master/3000.jpg?width=620&quality=85&auto=format&fit=max&s=19194e207969bdaa0638abd85d961497",
            width: 100,
            height: 100,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Chương 1 - Người bạn đến từ tương lai",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(
                  "December 1st, 2023",
                  style: TextStyle(
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
          const Text(
            "MIỄN PHÍ",
            style: TextStyle(fontSize: 16, color: Colors.orange),
          )
        ],
      ),
    );
  }
}
