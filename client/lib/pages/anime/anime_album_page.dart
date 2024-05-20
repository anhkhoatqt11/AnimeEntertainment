import 'package:anime_and_comic_entertainment/components/animes/AnimeAlbumItem.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';

import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:getwidget/types/gf_loader_type.dart';

class AnimeAlbumPage extends StatefulWidget {
  final dynamic albumId;
  final String? albumName;
  const AnimeAlbumPage(
      {super.key, required this.albumId, required this.albumName});

  @override
  State<AnimeAlbumPage> createState() => _AnimeAlbumPageState();
}

class _AnimeAlbumPageState extends State<AnimeAlbumPage> {
  List<Animes> listAnimeItem = [];
  final controller = ScrollController();
  static const limit = 6;
  int page = 1;
  bool hasData = true;

  @override
  void initState() {
    FirebaseApi().listenEvent(context);
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
      var newItems = await AnimesApi.getAnimeAlbumContent(context,
          widget.albumId.toString(), limit.toString(), page.toString());
      final isLastPage = newItems.length < limit;
      newItems.forEach((item) {
        setState(() {
          listAnimeItem.add(Animes(
            id: item.id,
            coverImage: item.coverImage,
            movieName: item.movieName,
          ));
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
        body: listAnimeItem.isEmpty
            ? const Center(
                child: GFLoader(type: GFLoaderType.circle),
              )
            : ListView(
                controller: controller,
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: List.generate(listAnimeItem.length, (index) {
                        if (index < listAnimeItem.length) {
                          return AnimeAlbumItem(
                            urlImage: listAnimeItem[index].coverImage,
                            nameItem: listAnimeItem[index].movieName,
                            animeId: listAnimeItem[index].id,
                          );
                        } else {
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: hasData == true
                                  ? const Center(
                                      child:
                                          GFLoader(type: GFLoaderType.circle),
                                    )
                                  : null);
                        }
                      }),
                    ),
                  )
                ],
              ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
