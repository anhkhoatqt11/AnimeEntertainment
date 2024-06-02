// ignore_for_file: use_build_context_synchronously

import 'package:anime_and_comic_entertainment/components/animes/WatchingHistoriesList.dart';
import 'package:anime_and_comic_entertainment/components/comic/TopRankingComic.dart';
import 'package:anime_and_comic_entertainment/components/donate/DonatePackageListHome.dart';
import 'package:anime_and_comic_entertainment/components/ui/AlertChoiceDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/components/ui/DonateBannerHome.dart';
import 'package:anime_and_comic_entertainment/components/ui/ReceivedCoinDialog.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_page.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_buy_chapter.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_chapter_comment.dart';
import 'package:anime_and_comic_entertainment/pages/donate/donate_page.dart';
import 'package:anime_and_comic_entertainment/pages/donate/donate_podium_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/profile_page.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_page.dart';
import 'package:anime_and_comic_entertainment/pages/search/search_result_page.dart';
import 'package:anime_and_comic_entertainment/pages/payment.dart';
import 'package:anime_and_comic_entertainment/pages/profile/bookmark_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/edit_profile_page.dart';
import 'package:anime_and_comic_entertainment/pages/notification/notification.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_detail.dart';
import 'package:anime_and_comic_entertainment/pages/notification/notification.dart';
import 'package:anime_and_comic_entertainment/providers/comic_detail_provider.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:anime_and_comic_entertainment/services/challenges_api.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:anime_and_comic_entertainment/services/daily_quests_api.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:anime_and_comic_entertainment/services/reports_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            onPressed: () {},
            child: const Text("Buy"),
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
                  builder: (_) => ReceivedCoinDialog(
                        content:
                            "Chúc mừng bạn đã vượt thử thách với ${10} điểm. Phần thưởng ${(10 / 10).ceil()} skycoins sẽ được gửi vào túi của bạn.",
                      ));
            },
            child: const Text("alert dialog"),
          ),
          ElevatedButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (_) => CustomAlertChoiceDialog(
                        yesContent: "Đăng xuất",
                        noContent: "Bỏ qua",
                        content:
                            "Việc đăng xuất sẽ hạn chế một số tính năng của ứng dụng",
                        title: "Đăng xuất",
                        action: () {},
                      ));
            },
            child: const Text("alert choice dialog"),
          ),
          ElevatedButton(
              onPressed: () async {
                var result = await AuthApi.login(
                    context, "+84979683590", "Dangthaison@123");
              },
              child: const Text("auto login")),
          ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChallengePage(),
                  ),
                );
              },
              child: const Text("challenge page")),
          ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationPage(),
                  ),
                );
              },
              child: const Text("notification page")),
          ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              child: const Text("profile page")),
          ElevatedButton(
              onPressed: () async {
                var result = await ChallengesApi.getChallengesQuestion(
                  context,
                );
                print(result);
              },
              child: const Text("fetch question")),
          ElevatedButton(
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 270,
                      color: const Color(0xFF2A2A2A),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                            child: Text("Mở khóa truyện để tiếp tục đọc nhé !",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/images/loadingcomicimage.png',
                                      image:
                                          "https://i1.wp.com/omnigeekempire.com/wp-content/uploads/2021/07/4ff8304c8113335ee40a9448239dc11d1626614065_main.jpg?fit=1024%2C728&ssl=1",
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Konosuba",
                                            style: TextStyle(
                                                color: Utils.primaryColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                          const Text(
                                            "Chương 24",
                                            style: TextStyle(
                                                color: Color(0xFFE9E9E9),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "30",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            "assets/images/skycoin.png",
                                            width: 16,
                                            height: 16,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Color(0xFF686868),
                            thickness: .5,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8.0, 16, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.account_balance_wallet_outlined,
                                      color: Utils.primaryColor,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "Bạn hiện đang có:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      Utils.formatNumberWithDots(
                                          Provider.of<UserProvider>(context)
                                              .user
                                              .coinPoint),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      "assets/images/skycoin.png",
                                      width: 16,
                                      height: 16,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8.0, 16, 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GFButton(
                                    onPressed: () {},
                                    color: Utils.primaryColor,
                                    text: "Nạp thêm",
                                    size: GFSize.LARGE,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Utils.primaryColor),
                                    type: GFButtonType.outline2x,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: GFButton(
                                    onPressed: () {},
                                    color: Utils.primaryColor,
                                    text: "Mua ngay",
                                    size: GFSize.LARGE,
                                    type: GFButtonType.solid,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text("test modal pay comic chapter")),
          ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              child: const Text("profile page")),
          ElevatedButton(
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 270,
                      color: const Color(0xFF2A2A2A),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                            child: Text("Mở khóa truyện để tiếp tục đọc nhé !",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 8),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/images/loadingcomicimage.png',
                                      image:
                                          "https://i1.wp.com/omnigeekempire.com/wp-content/uploads/2021/07/4ff8304c8113335ee40a9448239dc11d1626614065_main.jpg?fit=1024%2C728&ssl=1",
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Konosuba",
                                          style: TextStyle(
                                              color: Utils.primaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        const Text(
                                          "Chương 24",
                                          style: TextStyle(
                                              color: Color(0xFFE9E9E9),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "30",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          "assets/images/skycoin.png",
                                          width: 16,
                                          height: 16,
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                          const Divider(
                            color: Color(0xFF686868),
                            thickness: .5,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8.0, 16, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.account_balance_wallet_outlined,
                                      color: Utils.primaryColor,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "Bạn hiện đang có:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      Utils.formatNumberWithDots(
                                          Provider.of<UserProvider>(context)
                                              .user
                                              .coinPoint),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      "assets/images/skycoin.png",
                                      width: 16,
                                      height: 16,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8.0, 16, 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GFButton(
                                    onPressed: () {},
                                    color: Utils.primaryColor,
                                    text: "Nạp thêm",
                                    size: GFSize.LARGE,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Utils.primaryColor),
                                    type: GFButtonType.outline2x,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: GFButton(
                                    onPressed: () {},
                                    color: Utils.primaryColor,
                                    text: "Mua ngay",
                                    size: GFSize.LARGE,
                                    type: GFButtonType.solid,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text("test modal pay comic chapter")),
          ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonatePage(),
                  ),
                );
              },
              child: const Text("donate page")),
          ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonatePodium(),
                  ),
                );
              },
              child: const Text("bxh donate"))
        ]),
      );
    }));
  }
}
