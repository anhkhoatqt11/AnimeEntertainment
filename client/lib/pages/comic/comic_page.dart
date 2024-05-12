import 'package:anime_and_comic_entertainment/components/comic/ComicAlbum.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicBanner.dart';
import 'package:anime_and_comic_entertainment/components/comic/NewChapterList.dart';
import 'package:anime_and_comic_entertainment/components/comic/ReadingHistoresList.dart';
import 'package:anime_and_comic_entertainment/components/ui/DonateBannerHome.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';

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
          children: [
            ComicBanner(),
            Consumer(builder: (context, watch, _) {
              final user = Provider.of<UserProvider>(context).user;
              return user.authentication['sessionToken'] != ""
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            "Đọc tiếp",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 168,
                          child: ReadingHistoriesList(
                            userId: user.id,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink();
            }),
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
              child: SizedBox(height: 256, child: NewChapterList()),
            ),
            // Top unlock...
            Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: DonateBannerHome(
                urlAsset: 'assets/images/donate1.png',
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: ComicAlbumComponent(),
            ),
          ],
        ));
  }
}
