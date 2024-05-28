// ignore_for_file: use_build_context_synchronously

import 'package:anime_and_comic_entertainment/components/animes/WatchingHistoriesList.dart';
import 'package:anime_and_comic_entertainment/components/comic/TopRankingComic.dart';
import 'package:anime_and_comic_entertainment/components/donate/DonatePackageListHome.dart';
import 'package:anime_and_comic_entertainment/components/ui/AlertChoiceDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/components/ui/DonateBannerHome.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_page.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_comment.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_page.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_result_page.dart';
import 'package:anime_and_comic_entertainment/pages/payment.dart';
import 'package:anime_and_comic_entertainment/pages/profile/bookmark_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/edit_profile_page.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_detail.dart';
import 'package:anime_and_comic_entertainment/pages/notification/notification.dart';
import 'package:anime_and_comic_entertainment/providers/comic_detail_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/services/daily_quests_api.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:anime_and_comic_entertainment/services/reports_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
    FirebaseApi().listenEvent(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, watch, _) {
      final user = Provider.of<UserProvider>(context).user;
      return Container(
        width: double.infinity,
        color: const Color(0xFF141414),
        child: ListView(children: [
          ElevatedButton(
              onPressed: () async {
                var result = await AnimesApi.checkUserHistoryHadSeenEpisode(
                    context,
                    "65ffd16d1bee1791e51d5195",
                    "65f709463fafb1d0bdce1bb0");
                print(result);
              },
              child: const Text("test")),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComicChapterComment(
                    sourceId: "65ec659f05c5cb2ad67cfb3d",
                    type: "chapter",
                  ),
                ),
              );
            },
            child: const Text("Comment"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
            child: const Text("Notifications"),
          ),
          ElevatedButton(
            onPressed: () async {
              await ReportsApi.sendUserReport(
                  context,
                  'lalala',
                  '664b0912d9d500ecd8b4a5ff',
                  '664b0912d9d500ecd8b4a5ff',
                  "comic",
                  '664b0912d9d500ecd8b4a5ff',
                  '664b0912d9d500ecd8b4a5ff');
            },
            child: const Text("send report"),
          ),
          ElevatedButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (_) => CustomAlertDialog(
                        content: "Số điện thoại này chưa được đăng ký",
                        title: "Thông báo",
                        action: () {},
                      ));
            },
            child: const Text("alert dialog"),
          ),
          ElevatedButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (_) => CustomAlertChoiceDialog(
                        content:
                            "Việc đăng xuất sẽ hạn chế một số tính năng của ứng dụng",
                        title: "Đăng xuất",
                        action: () {},
                      ));
            },
            child: const Text("alert choice dialog"),
          ),
        ]),
      );
    }));
  }
}
