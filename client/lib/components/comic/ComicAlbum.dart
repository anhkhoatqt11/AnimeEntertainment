import 'package:anime_and_comic_entertainment/components/comic/ComicItem.dart';
import 'package:anime_and_comic_entertainment/components/comic/TopRankingComic.dart';
import 'package:anime_and_comic_entertainment/components/ui/DonateBannerHome.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_album_page.dart';
import 'package:flutter/material.dart';

import 'package:anime_and_comic_entertainment/model/album.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:shimmer/shimmer.dart';

class ComicAlbumItem extends StatefulWidget {
  final dynamic idList;
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
        shrinkWrap: true,
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

  @override
  void dispose() {
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
                id: element.id,
                albumName: element.albumName,
                comicList: element.comicList));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return listAlbum.isEmpty
        ? SizedBox(
            height: 193,
            child: ListView(
              shrinkWrap: true,
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
                        width: 125,
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
                        width: 125,
                        height: 187,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                      )),
                ),
              ],
            ),
          )
        : Column(
            children: List.generate(listAlbum.length, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ComicAlbumPage(
                                    comicIdList: listAlbum[index].comicList,
                                    albumName: listAlbum[index].albumName,
                                  )),
                        );
                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              listAlbum[index].albumName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const FaIcon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.white,
                            size: 12,
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                    height: 256,
                    child: ComicAlbumItem(
                        idList: listAlbum[index].comicList.toString())),
                index == 2
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DonateBannerHome(
                          urlAsset: 'assets/images/donate2.png',
                        ),
                      )
                    : const SizedBox.shrink(),
                index == 4
                    ? const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              "️🏆 Bảng xếp hạng",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: TopRankingComic(),
                          ),
                        ],
                      )
                    : Container(),
              ],
            );
          }));
  }
}
