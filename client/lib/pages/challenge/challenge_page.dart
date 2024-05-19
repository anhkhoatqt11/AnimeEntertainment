import 'package:anime_and_comic_entertainment/components/challenge/DailyLoginList.dart';
import 'package:anime_and_comic_entertainment/components/challenge/DailyQuest.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_test_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:anime_and_comic_entertainment/services/daily_quests_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:anime_and_comic_entertainment/components/challenge/Podium.dart';
import 'package:provider/provider.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(
              "Thử thách",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              "Bảng xếp hạng hàng tuần",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Podium(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Chưa có xếp hạng",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                GradientButton(
                    content: "Tham gia ngay",
                    action: () {
                      Provider.of<NavigatorProvider>(context, listen: false)
                          .setShow(false);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChallengeTest()));
                    },
                    height: 45,
                    width: 160,
                    disabled: false)
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              "Nhiệm vụ hằng ngày ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
            child: Provider.of<UserProvider>(context, listen: false)
                        .user
                        .authentication['sessionToken'] ==
                    ""
                ? Text(
                    "Vui lòng đăng nhập để nhận thưởng",
                    style: TextStyle(color: Utils.accentColor, fontSize: 10),
                  )
                : const SizedBox.shrink(),
          ),
          const DailyQuestList(),
        ],
      ),
    );
  }
}
