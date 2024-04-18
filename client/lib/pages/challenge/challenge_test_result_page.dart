import 'package:anime_and_comic_entertainment/components/challenge/ResultItem.dart';
import 'package:anime_and_comic_entertainment/components/challenge/ResultList.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

class ChallengeTestResult extends StatefulWidget {
  const ChallengeTestResult({super.key});

  @override
  State<ChallengeTestResult> createState() => _ChallengeTestResultState();
}

class _ChallengeTestResultState extends State<ChallengeTestResult> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: GFAppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF141414),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thử thách",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kết quả",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "4/10",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ],
          )),
      body: const ResultListItem(),
    );
  }
}
