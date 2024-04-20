import 'package:anime_and_comic_entertainment/components/challenge/ResultList.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

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
      body: ResultListItem(
        userAnswers: userAnswers,
        isCorrect: isCorrect,
        totalPoints: totalPoints,
      ),
    );
  }
}
