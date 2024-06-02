import 'package:anime_and_comic_entertainment/components/comic/ComicAlbum.dart';
import 'package:anime_and_comic_entertainment/components/comic/ComicBanner.dart';
import 'package:anime_and_comic_entertainment/components/comic/NewChapterList.dart';
import 'package:anime_and_comic_entertainment/components/comic/ReadingHistoresList.dart';
import 'package:anime_and_comic_entertainment/components/ui/DonateBannerHome.dart';
import 'package:anime_and_comic_entertainment/pages/donate/donate_page.dart';
import 'package:anime_and_comic_entertainment/pages/notification/notification.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';

class ComicPage extends StatefulWidget {
  const ComicPage({super.key});

  @override
  State<ComicPage> createState() => _ComicPageState();
}

class _ComicPageState extends State<ComicPage> {
  @override
  void initState() {
    FirebaseApi().listenEvent(context);
    super.initState();
  }

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
            Provider.of<UserProvider>(context, listen: false)
                        .user
                        .authentication['sessionToken'] !=
                    ""
                ? Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      GFIconButton(
                        icon: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          Provider.of<NavigatorProvider>(context, listen: false)
                              .setShow(false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationPage()));
                        },
                        type: GFButtonType.transparent,
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Consumer(builder: (context, watch, _) {
                          final user = Provider.of<UserProvider>(context).user;
                          return user.authentication['sessionToken'] != ""
                              ? user.notificationSentCount != 0
                                  ? Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                      child: Text(
                                        user.notificationSentCount.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    )
                                  : const SizedBox.shrink()
                              : const SizedBox.shrink();
                        }),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            GFIconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 24),
              onPressed: () {
                Provider.of<NavigatorProvider>(context, listen: false)
                    .setShow(false);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              type: GFButtonType.transparent,
            ),
          ],
        ),
        body: ListView(
          children: [
            const ComicBanner(),
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
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Chương mới, xem ngay!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: SizedBox(height: 256, child: NewChapterList()),
            ),
            // Top unlock...
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DonatePage()));
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: DonateBannerHome(
                  urlAsset: 'assets/images/donate1.png',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: ComicAlbumComponent(),
            ),
          ],
        ));
  }
}
