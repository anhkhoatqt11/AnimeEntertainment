import 'package:anime_and_comic_entertainment/components/challenge/DailyQuest.dart';
import 'package:anime_and_comic_entertainment/components/challenge/Podium.dart';
import 'package:anime_and_comic_entertainment/components/ui/AlertDialog.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/model/challenges.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_test_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/challenges_api.dart';
import 'package:anime_and_comic_entertainment/services/daily_quests_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  late Future<int> _userPositionFuture;
  late Future<List<UserChallenge>> _userChallengesFuture;

  @override
  void initState() {
    super.initState();
    final userId = Provider.of<UserProvider>(context, listen: false).user.id;
    _userPositionFuture = ChallengesApi.getUserCurrentPosition(userId);
    _userChallengesFuture = ChallengesApi.getUsersChallengesPoints();
  }

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
            child: FutureBuilder<int>(
              future: _userPositionFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final userPosition = snapshot.data ?? -1;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userPosition > 0
                            ? "Thứ hạng: $userPosition"
                            : "Chưa có xếp hạng",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      GradientButton(
                        content: "Tham gia ngay",
                        action: () async {
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          final navigatorProvider =
                              Provider.of<NavigatorProvider>(context,
                                  listen: false);

                          if (userProvider
                                  .user.authentication['sessionToken'] ==
                              "") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertDialog(
                                  content:
                                      "Vui lòng đăng nhập để tham gia thử thách",
                                  title: "Đăng nhập",
                                  action: () {},
                                );
                              },
                            );
                          } else {
                            final userId = userProvider.user.id;

                            // Get the user's challenges
                            List<UserChallenge> userChallenges =
                                await ChallengesApi.getUsersChallengesPoints();

                            // Check if the user has participated this week
                            bool hasParticipatedThisWeek =
                                userChallenges.any((challenge) {
                              return challenge.userId == userId &&
                                  challenge
                                      .getWeeklyPoints()
                                      .keys
                                      .contains(Utils.getCurrentYearWeek());
                            });

                            print(Utils.getCurrentYearWeek());
                            

                            if (hasParticipatedThisWeek) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    content:
                                        "Bạn đã tham gia thử thách trong tuần này. Vui lòng quay lại sau.",
                                    title: "Tham gia thử thách",
                                    action: () {},
                                  );
                                },
                              );
                            } else {
                              // Navigate to the challenge test page if the user hasn't participated
                              navigatorProvider.setShow(false);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChallengeTest()),
                              );
                            }
                          }
                        },
                        height: 45,
                        width: 160,
                        disabled: false,
                      )
                    ],
                  );
                }
              },
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
                    "Vui lòng đăng nhập để làm nhiệm vụ",
                    style: TextStyle(color: Utils.accentColor, fontSize: 10),
                  )
                : const SizedBox.shrink(),
          ),
          const DailyQuestList(),
          ElevatedButton(
            onPressed: () async {
              Provider.of<UserProvider>(context, listen: false)
                  .setWatchingTime(1);
              await DailyQuestsApi.updateQuestLog(context, "");
            },
            child: const Text("tang luot xem"),
          ),
          ElevatedButton(
            onPressed: () async {
              Provider.of<UserProvider>(context, listen: false)
                  .setReadingTime(1);
              await DailyQuestsApi.updateQuestLog(context, "");
            },
            child: const Text("tang luot doc"),
          )
        ],
      ),
    );
  }
}
