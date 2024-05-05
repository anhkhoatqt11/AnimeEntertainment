import 'package:anime_and_comic_entertainment/components/challenge/ResultList.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:provider/provider.dart';

class ChallengeTestResult extends StatelessWidget {
  final List<String> userAnswers;
  final List<bool> isCorrect;
  final int totalPoints;

  const ChallengeTestResult({
    required this.userAnswers,
    required this.isCorrect,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: GFAppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF141414),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thử thách",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Kết quả",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "${userAnswers.length}/${isCorrect.length}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
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
            bottom: 0,
            child: Container(
              color: Colors.purple, // Adjust color as needed
              padding: EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () {
                  Provider.of<NavigatorProvider>(context, listen: false)
                      .setShow(true);
                  Navigator.of(context, rootNavigator: true)
                      .popUntil((route) => route.isFirst);
                      // Navigator.of().pushAndRemoveUntil(newRoute, (route) => false)
                },
                child: Text(
                  'Quay trở về bảng xếp hạng',
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
