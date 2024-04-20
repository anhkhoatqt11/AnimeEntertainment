import 'package:anime_and_comic_entertainment/components/challenge/ResultItem.dart';
import 'package:flutter/material.dart';

class ResultListItem extends StatelessWidget {
  final List<String> userAnswers;
  final List<bool> isCorrect;
  final int totalPoints;

  const ResultListItem({
    required this.userAnswers,
    required this.isCorrect,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userAnswers.length,
      itemBuilder: (context, index) {
        return ResultItem(
          answer: userAnswers[index],
          isCorrect: isCorrect[index],
        );
      },
    );
  }
}
