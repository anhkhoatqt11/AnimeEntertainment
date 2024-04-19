import 'package:anime_and_comic_entertainment/components/comic/ComicChapter.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_detail.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore_for_file: prefer_const_constructors

class DetailComicPage extends StatelessWidget {
  final String comicId;

  DetailComicPage({required this.comicId});

  @override
  Widget build(BuildContext context) {
    List<int> listChapters = [1, 2, 3, 4, 5, 6];
    late Comics comic = Comics();
    Future<Comics> getAnimeDetailById() async {
      var result = await ComicsApi.getComicDetailById(context, comicId);
      return result;
    }

    getAnimeDetailById().then((value) => {comic = value});

    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF141414),
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.squarePlus))
          ],
        ),
        body: ListView(
          children: [
            Stack(children: [
              Column(
                children: [
                  Image.network(comic.landspaceImage ?? ""),
                  const SizedBox(
                    height: 25,
                  )
                ],
              ),
              Positioned(
                right: 10,
                bottom: 0,
                child: GradientSquareButton(
                  width: 165,
                  height: 50,
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ComicChapterDetail(
                          comicId: "65ec601305c5cb2ad67cfb37",
                          chapterIndex: 1,
                        ),
                      ),
                    );
                  },
                  content: 'ĐỌC NGAY',
                  cornerRadius: 10,
                ),
              )
            ]),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                    child: Text(
                      comic.comicName ?? "",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.bookOpenReader,
                            color: Colors.white,
                          ),
                          const Text(
                            'Lượt xem',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            comic.totalView.toString(),
                            style: const TextStyle(color: Colors.yellow),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.solidThumbsUp,
                            color: Colors.white,
                          ),
                          const Text(
                            'Lượt thích',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            comic.totalLike.toString(),
                            style: const TextStyle(color: Colors.yellow),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.solidFile,
                            color: Colors.white,
                          ),
                          const Text(
                            'Số chương',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            comic.comicName.toString(),
                            style: const TextStyle(color: Colors.yellow),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Tác giả: ${comic.author}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Họa sĩ: ${comic.artist}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Text(
                        'Thể loại: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Text(
                        'Nội dung bởi: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Mô tả: ${comic.description}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                              child: const Text(
                                'Danh sách chương',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 218, 113, 15)),
                              )),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                              child: const Text(
                                'Bình luận',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                      Container(
                          height: 3,
                          color: const Color.fromARGB(255, 218, 113, 15)),
                      Container(
                        color: Colors.black,
                        child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  '100 Chương',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Thứ 2 hàng tuần',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                          height: listChapters.length * 100,
                          child: Column(
                            children: List.generate(
                                listChapters.length, (index) => ComicChapter()),
                          ))
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
