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
        ? ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 125,
                      height: 187,
                      color: Colors.blue,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 125,
                      height: 187,
                      color: Colors.blue,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 125,
                      height: 187,
                      color: Colors.blue,
                    )),
              ),
            ],
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listComic.length,
            itemBuilder: (context, index) {
              return ComicItem(
                  urlImage: listComic[index].coverImage,
                  nameItem: listComic[index].comicName,
                  genres: listComic[index].genres);
            });
  }
}

// ListView(
//             scrollDirection: Axis.horizontal,
//             children: [
//               ComicItem(
//                 urlImage:
//                     'https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/_t_p_m_i_tagline-da6dcb8f74a8-1686305754531-gCwpREbI.png?v=0&maxW=260',
//                 nameItem: "Detective Conan",
//                 genres: null,
//               ),
//               ComicItem(
//                   urlImage:
//                       'https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/phim_moi-fdc866c73fd2-1708663384221-h3BlLVOZ.png?v=0&maxW=260',
//                   nameItem: "Doraemon",
//                   genres: null),
//               ComicItem(
//                   urlImage:
//                       'https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/vertical_poster-6edb1870a631-1708400087928-NOgvY5n0.png?v=0&maxW=260',
//                   nameItem: "Boruto",
//                   genres: null),
//               ComicItem(
//                   urlImage:
//                       'https://vnw-img-cdn.popsww.com/api/v2/containers/file2/cms_topic/vertical_poster-128d9c4e3cfc-1708400799846-D1MOGy71.png?v=0&maxW=260',
//                   nameItem: "Kizuna no Allele",
//                   genres: null)
//             ],
//           );