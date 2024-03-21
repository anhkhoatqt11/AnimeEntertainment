import 'package:anime_and_comic_entertainment/components/comic/ComicItem.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:flutter/material.dart';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:shimmer/shimmer.dart';

class ComicAlbumItem extends StatefulWidget {
  final dynamic? idList;
  const ComicAlbumItem({super.key, required this.idList});

  @override
  State<ComicAlbumItem> createState() => _ComicAlbumItemState();
}

class _ComicAlbumItemState extends State<ComicAlbumItem> {
  List<Comics> listComicItem = [];
  final controller = ScrollController();
  static const limit = 5;
  int page = 1;
  bool hasData = true;
  // final PagingController<int, Comics> _pagingController =
  //     PagingController(firstPageKey: 0);

  @override
  void initState() {
    // _pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
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
      if (!hasData) return;
      var newItems = await ComicsApi.getComicAlbumContent(
          context, widget.idList, limit.toString(), page.toString());
      final isLastPage = newItems.length < limit;
      newItems.forEach((item) {
        setState(() {
          listComicItem.add(Comics(
              id: item.id,
              coverImage: item.coverImage,
              comicName: item.comicName,
              genres: item.genres));
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
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: controller,
        itemCount: listComicItem.length + 1,
        itemBuilder: (context, index) {
          if (index < listComicItem.length) {
            final item = listComicItem[index];
            return ComicItem(
                urlImage: item.coverImage,
                nameItem: item.comicName,
                genres: item.genres);
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  @override
  void dispose() {
    // _pagingController.dispose();
    controller.dispose();
    super.dispose();
  }
}

class ComicAlbumComponent extends StatefulWidget {
  const ComicAlbumComponent({super.key});

  @override
  State<ComicAlbumComponent> createState() => _ComicAlbumComponentState();
}

class _ComicAlbumComponentState extends State<ComicAlbumComponent> {
  List<ComicAlbum> listAlbum = [];
  Future<List<ComicAlbum>> getAllAlbum() async {
    var result = await ComicsApi.getComicAlbum(context);
    return result;
  }

  @override
  void initState() {
    super.initState();
    getAllAlbum().then((value) => value.forEach((element) {
          setState(() {
            listAlbum.add(ComicAlbum(
                albumName: element.albumName, comicList: element.comicList));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return listAlbum.isEmpty
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
        : Column(
            children: [
              Text(
                listAlbum[0].albumName!,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                  height: 242,
                  child:
                      ComicAlbumItem(idList: listAlbum[0].comicList.toString()))
            ],
          );
  }
}
