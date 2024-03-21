import 'package:anime_and_comic_entertainment/components/comic/ComicAlbum.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicBanner.dart';
import 'package:anime_and_comic_entertainment/components/CurrentReadingUser.dart';
import 'package:anime_and_comic_entertainment/components/HotSeries.dart';
import 'package:anime_and_comic_entertainment/components/MainBanner.dart';
import 'package:anime_and_comic_entertainment/components/comic/NewChapterList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

class ComicPage extends StatelessWidget {
  const ComicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: GFAppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF141414),
          title: const Text(
            "Truyện Tranh",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            GFIconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              onPressed: () {},
              type: GFButtonType.transparent,
            ),
          ],
        ),
        body: ListView(
          children: const [
            ComicBanner(),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Đọc tiếp",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: SizedBox(
                height: 228,
                child: CurrentReadingUser(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Chương mới, xem ngay!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: SizedBox(height: 274, child: NewChapterList()),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Album truyện!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: SizedBox(height: 1000, child: ComicAlbumComponent()),
            ),
          ],
        ));
  }
}
