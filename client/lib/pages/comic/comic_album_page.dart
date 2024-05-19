import 'package:anime_and_comic_entertainment/components/comic/ComicLandspaceItem.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';

import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_loader_type.dart';

class ComicAlbumPage extends StatefulWidget {
  final dynamic comicIdList;
  final String? albumName;
  const ComicAlbumPage(
      {super.key, required this.comicIdList, required this.albumName});

  @override
  State<ComicAlbumPage> createState() => _ComicAlbumPageState();
}

class _ComicAlbumPageState extends State<ComicAlbumPage> {
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
      var newItems = await ComicsApi.getComicAlbumContent(context,
          widget.comicIdList.toString(), limit.toString(), page.toString());
      final isLastPage = newItems.length < limit;
      newItems.forEach((item) {
        setState(() {
          listComicItem.add(Comics(
              id: item.id,
              coverImage: item.coverImage,
              comicName: item.comicName,
              genres: item.genres,
              description: item.description));
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
    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: GFAppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: GFIconButton(
              splashColor: Colors.transparent,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              type: GFButtonType.transparent,
            ),
            centerTitle: true,
            title: Text(
              widget.albumName!,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            )),
        body: listComicItem.isEmpty
            ? const Center(
                child: GFLoader(type: GFLoaderType.circle),
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                controller: controller,
                itemCount: listComicItem.length + 1,
                itemBuilder: (context, index) {
                  if (index < listComicItem.length) {
                    final item = listComicItem[index];
                    return ComicLandspaceItem(
                      comicId: item.id,
                      urlImage: item.coverImage,
                      nameItem: item.comicName,
                      genres: item.genres,
                      description: item.description,
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
                }));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
