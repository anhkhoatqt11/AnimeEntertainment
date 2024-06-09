import 'package:anime_and_comic_entertainment/components/challenge/ResultList.dart';
import 'package:anime_and_comic_entertainment/components/ui/Button.dart';
import 'package:anime_and_comic_entertainment/components/ui/ReceivedCoinDialog.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:provider/provider.dart';

class ChallengeTestResult extends StatelessWidget {
  final List<String> userAnswers;
  final List<bool> isCorrect;
  final int totalPoints;

  const ChallengeTestResult({
    super.key,
    required this.userAnswers,
    required this.isCorrect,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _showDialog(context),
        builder: ((context, snapshot) => Scaffold(
              backgroundColor: const Color(0xFF141414),
              body: Stack(
                children: [
                  ResultListItem(
                    userAnswers: userAnswers,
                    isCorrect: isCorrect,
                    totalPoints: totalPoints,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: GradientButton(
                      content: 'Quay trở về bảng xếp hạng',
                      action: () {
                        Provider.of<NavigatorProvider>(context, listen: false)
                            .setShow(true);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChallengePage()),
                            (route) => route.isFirst);
                      },
                      height: 50,
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      disabled: false,
                    ),
                  ),
                ],
              ),
            )));
  }

  Future<void> _showDialog(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Provider.of<UserProvider>(context, listen: false)
          .getIsNotifyPassChallenges) {
        Provider.of<UserProvider>(context, listen: false)
            .setNotifyPassChallenges(true);
        showDialog(
            context: context,
            builder: (_) => ReceivedCoinDialog(
                  content:
                      "Chúc mừng bạn đã vượt thử thách với $totalPoints điểm. Phần thưởng ${(totalPoints / 10).ceil()} skycoins sẽ được gửi vào túi của bạn.",
                ));
      }
    });
  }
}
