import 'package:anime_and_comic_entertainment/components/challenge/ResultItem.dart';
import 'package:flutter/material.dart';

class ResultListItem extends StatelessWidget {
  final List<String> userAnswers;
  final List<bool> isCorrect;
  final int totalPoints;

  const ResultListItem({
    super.key,
    required this.userAnswers,
    required this.isCorrect,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userAnswers.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Thử thách",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Kết quả",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "${userAnswers.length}/${isCorrect.length}",
                          style: const TextStyle(
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
              ResultItem(
                answer: userAnswers[index],
                isCorrect: isCorrect[index],
              )
            ],
          );
        } else
          return ResultItem(
            answer: userAnswers[index],
            isCorrect: isCorrect[index],
          );
      },
    );
  }
}
