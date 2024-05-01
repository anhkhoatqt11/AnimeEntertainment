import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_comment.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore_for_file: prefer_const_constructors

class ComicChapterDetail extends StatefulWidget {
  final Comics comic;
  final int index;

  const ComicChapterDetail({required this.comic, required this.index});

  @override
  State<ComicChapterDetail> createState() => _ComicChapterDetailState();
}

class _ComicChapterDetailState extends State<ComicChapterDetail> {
  @override
  Widget build(BuildContext context) {
    Comics comic = widget.comic;
    int chapterIndex = widget.index;
    print(comic);
    int contentLength = comic.chapterList![chapterIndex]['content'].length + 1;

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
          title: Text(comic.chapterList![chapterIndex]['chapterName']),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF141414)),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: contentLength,
          itemBuilder: (context, index) => index == contentLength - 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent),
                        child: IconButton(
                            onPressed: () {
                              if (chapterIndex == 0) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ComicChapterDetail(
                                    comic: comic,
                                    index: chapterIndex - 1,
                                  ),
                                ),
                              );
                            },
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
                            onPressed: () {
                              if (chapterIndex == comic.chapterList!.length - 1)
                                return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ComicChapterDetail(
                                    comic: comic,
                                    index: chapterIndex + 1,
                                  ),
                                ),
                              );
                            },
                            icon: const Row(
                              children: [
                                Text(
                                  "Sau",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
              : Image.network(
                  comic.chapterList![chapterIndex]['content'][index],
                ),
        ),
      ),
    );
  }
}
