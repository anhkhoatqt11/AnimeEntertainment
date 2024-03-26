import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';

class AdTiming extends StatelessWidget {
  final String content;
  const AdTiming({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color.fromARGB(229, 30, 30, 52)),
      child: Center(
          child: Text(
        content,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      )),
    );
  }
}
