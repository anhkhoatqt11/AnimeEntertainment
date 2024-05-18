import 'package:anime_and_comic_entertainment/components/animes/CurrentView.dart';
import 'package:anime_and_comic_entertainment/components/comic/CurrentRead.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/model/readingHistories.dart';
import 'package:anime_and_comic_entertainment/model/watchingHistories.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:shimmer/shimmer.dart';

class ReadingHistoriesList extends StatefulWidget {
  final String userId;
  const ReadingHistoriesList({super.key, required this.userId});

  @override
  State<ReadingHistoriesList> createState() => _ReadingHistoriesListState();
}

class _ReadingHistoriesListState extends State<ReadingHistoriesList> {
  List<ReadingHistories> listChapter = [];
  final controller = ScrollController();
  static const limit = 5;
  int page = 1;
  bool hasData = true;

  @override
  void initState() {
    fetch();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
    super.initState();
  }

  Future fetch() async {
    try {
      if (hasData == false) return;
      var newItems = await ComicsApi.getReadingHistories(
          context, widget.userId, limit.toString(), page.toString());
      final isLastPage = newItems.length < limit;
      newItems.forEach((element) {
        setState(() {
          listChapter.add(ReadingHistories(
              id: element.id,
              coverImage: element.coverImage,
              chapterName: element.chapterName,
              ownerId: element.ownerId,
              ownerChapterList: element.ownerChapterList));
        });
      });
      if (isLastPage) {
        setState(() {
          hasData = false;
        });
      } else {
        setState(() {
          page++;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return listChapter.isEmpty
        ? ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 240,
                      height: 108,
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
                      width: 240,
                      height: 108,
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
                      width: 240,
                      height: 108,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4)),
                    )),
              ),
            ],
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listChapter.length,
            controller: controller,
            itemBuilder: (context, index) {
              if (index < listChapter.length) {
                return CurrentRead(
                  urlImage: listChapter[index].coverImage!,
                  nameItem: listChapter[index].chapterName!,
                  comic: Comics(
                      id: listChapter[index].ownerId!,
                      chapterList: listChapter[index].ownerChapterList!),
                  chapterId: listChapter[index].id!,
                );
              } else {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: hasData == true
                        ? const Center(
                            child: GFLoader(type: GFLoaderType.circle),
                          )
                        : null);
              }
            });
  }
}
