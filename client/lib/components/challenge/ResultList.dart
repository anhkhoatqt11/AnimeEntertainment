import 'package:anime_and_comic_entertainment/components/challenge/ResultItem.dart';
import 'package:flutter/material.dart';

class ResultListItem extends StatefulWidget {
  const ResultListItem({super.key});

  @override
  State<ResultListItem> createState() => _ResultListItemState();
}

class _ResultListItemState extends State<ResultListItem> {
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ResultItem(
          answer: items[index],
          isCorrect: true,
        );
      },
    );
  }
}
