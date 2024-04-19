import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_comment.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore_for_file: prefer_const_constructors

class ComicChapterDetail extends StatelessWidget {
  final String comicId;
  final int chapterIndex;

  const ComicChapterDetail({required this.comicId, required this.chapterIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text("Chương 2"),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF141414)),
      body: ListView(
        children: [
          Image.network(
              "https://pops-comic-vn.akamaized.net/api/v2/containers/file4/cms_comic/64747be2286fff08a3fe5c14/64747d88286fff08a3fe5c17/1_1685355928272-parts-00.jpg"),
          Image.network(
              "https://pops-comic-vn.akamaized.net/api/v2/containers/file4/cms_comic/64747be2286fff08a3fe5c14/64747d88286fff08a3fe5c17/1_1685355928272-parts-01.jpg"),
          Image.network(
              "https://pops-comic-vn.akamaized.net/api/v2/containers/file4/cms_comic/64747be2286fff08a3fe5c14/64747d88286fff08a3fe5c17/1_1685355928272-parts-02.jpg"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: FaIcon(
                                FontAwesomeIcons.arrowLeft,
                                color: Colors.white,
                              )),
                          Text(
                            "Trước",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ))),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComicChapterComment(
                          comicId: "65ec601305c5cb2ad67cfb37",
                          chapterIndex: 1,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  child: FaIcon(
                    FontAwesomeIcons.comment,
                    color: Colors.white,
                  )),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Row(
                        children: [
                          Text(
                            "Sau",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: FaIcon(
                                FontAwesomeIcons.arrowRight,
                                color: Colors.white,
                              ))
                        ],
                      )))
            ],
          )
        ],
      ),
    );
  }
}
