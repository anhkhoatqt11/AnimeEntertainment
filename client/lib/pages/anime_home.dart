import 'package:anime_and_comic_entertainment/components/HotSeries.dart';
import 'package:anime_and_comic_entertainment/components/MainBanner.dart';
import 'package:flutter/material.dart';

class AnimePage extends StatelessWidget {
  const AnimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HotSeries(),
    );
  }
}
