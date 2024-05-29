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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:provider/provider.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  late Future<int> _userPositionFuture;
  late String challengeName = "";
  late DateTime endTime = DateTime.now();
  Future<void> getChallengeInformation() async {
    var result = await ChallengesApi.getChallegenInformation(context);
    setState(() {
      challengeName = result['challengeName'];
      endTime = DateTime.parse(result['endTime']).toLocal();
    });
  }

  @override
  void initState() {
    super.initState();
    getChallengeInformation();
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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              challengeName,
              style: TextStyle(
                  color: Utils.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  endTime.isAfter(DateTime.now())
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: FaIcon(
                            FontAwesomeIcons.hourglassHalf,
                            color: Utils.accentColor,
                            size: 10,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Text(
                    endTime.isAfter(DateTime.now())
                        ? (endTime.difference(DateTime.now()).inHours > 0
                            ? "Còn lại ${endTime.difference(DateTime.now()).inHours} giờ thử thách"
                            : "Còn lại ${endTime.difference(DateTime.now()).inMinutes} phút thử thách")
                        : "Đã kết thúc",
                    style: TextStyle(
                        color: endTime.isAfter(DateTime.now())
                            ? Utils.accentColor
                            : Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )),
          const SizedBox(
            height: 5,
          ),
          const Podium(),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
          //   child: FutureBuilder<int>(
          //     future: _userPositionFuture,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(
          //           child: GFLoader(type: GFLoaderType.circle),
          //         );
          //       } else if (snapshot.hasError) {
          //         return Center(
          //           child: Text('Error: ${snapshot.error}'),
          //         );
          //       } else {
          //         final userPosition = snapshot.data ?? -1;
          //         return Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               userPosition > 0
          //                   ? "Thứ hạng: $userPosition"
          //                   : "Chưa có xếp hạng",
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //             GradientSquareButton(
          //               content: "Tham gia ngay",
          //               action: () async {
          //                 final userProvider =
          //                     Provider.of<UserProvider>(context, listen: false);
          //                 final navigatorProvider =
          //                     Provider.of<NavigatorProvider>(context,
          //                         listen: false);

          //                 if (userProvider
          //                         .user.authentication['sessionToken'] ==
          //                     "") {
          //                   showDialog(
          //                     context: context,
          //                     builder: (BuildContext context) {
          //                       return CustomAlertDialog(
          //                         content:
          //                             "Vui lòng đăng nhập để tham gia thử thách",
          //                         title: "Đăng nhập",
          //                         action: () {},
          //                       );
          //                     },
          //                   );
          //                 } else {
          //                   final userId = userProvider.user.id;

          //                   // Get the user's challenges
          //                   List<UserChallenge> userChallenges =
          //                       await ChallengesApi.getUsersChallengesPoints();

          //                   // Check if the user has participated this week
          //                   bool hasParticipatedThisWeek =
          //                       userChallenges.any((challenge) {
          //                     return challenge.userId == userId &&
          //                         challenge
          //                             .getWeeklyPoints()
          //                             .keys
          //                             .contains(Utils.getCurrentYearWeek());
          //                   });

          //                   print(Utils.getCurrentYearWeek());

          //                   if (hasParticipatedThisWeek) {
          //                     showDialog(
          //                       context: context,
          //                       builder: (BuildContext context) {
          //                         return CustomAlertDialog(
          //                           content:
          //                               "Bạn đã tham gia thử thách trong tuần này. Vui lòng quay lại sau.",
          //                           title: "Tham gia thử thách",
          //                           action: () {},
          //                         );
          //                       },
          //                     );
          //                   } else {
          //                     // Navigate to the challenge test page if the user hasn't participated
          //                     navigatorProvider.setShow(false);
          //                     Navigator.pushReplacement(
          //                       context,
          //                       MaterialPageRoute(
          //                           builder: (context) => ChallengeTest()),
          //                     );
          //                   }
          //                 }
          //               },
          //               height: 45,
          //               width: 160,
          //               cornerRadius: 8,
          //             )
          //           ],
          //         );
          //       }
          //     },
          //   ),
          // ),
          Consumer(builder: (BuildContext context, value, Widget? child) {
            final userInfo = Provider.of<UserProvider>(context).user;
            print(userInfo.challenges);
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userInfo.challenges.isNotEmpty
                        ? "Kết quả thử thách:"
                        : "Chưa vượt thử thách",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  userInfo.challenges.isEmpty
                      ? GradientSquareButton(
                          content: "Tham gia ngay",
                          action: () async {
                            final userProvider = Provider.of<UserProvider>(
                                context,
                                listen: false);
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
                              // Navigate to the challenge test page if the user hasn't participated
                              navigatorProvider.setShow(false);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChallengeTest()),
                              );
                            }
                          },
                          height: 45,
                          width: 160,
                          cornerRadius: 8,
                        )
                      : Text(
                          "${userInfo.challenges[0]['point']} điểm",
                          style: TextStyle(
                            color: Utils.accentColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ],
              ),
            );
          }),
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
        ],
      ),
    );
  }
}
