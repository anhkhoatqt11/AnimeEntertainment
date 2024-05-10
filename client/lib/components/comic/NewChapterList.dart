import 'package:anime_and_comic_entertainment/components/comic/ComicItem.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewChapterList extends StatefulWidget {
  const NewChapterList({super.key});

  @override
  State<NewChapterList> createState() => _NewChapterListState();
}

class _NewChapterListState extends State<NewChapterList> {
  List<Comics> listComic = [];
  Future<List<Comics>> getNewChapterComic() async {
    var result = await ComicsApi.getNewChapterComic(context);
    return result;
  }

  @override
  void initState() {
    super.initState();
    getNewChapterComic().then((value) => value.forEach((element) {
          setState(() {
            listComic.add(Comics(
                id: element.id,
                coverImage: element.coverImage,
                comicName: element.comicName,
                genres: element.genres));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return listComic.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 191,
                        height: 187,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 191,
                        height: 187,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 191,
                        height: 187,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                      )),
                ),
              ],
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listComic.length,
            itemBuilder: (context, index) {
              return ComicItem(
                urlImage: listComic[index].coverImage,
                nameItem: listComic[index].comicName,
                genres: listComic[index].genres,
                comicId: listComic[index].id,
              );
            });
  }
}
