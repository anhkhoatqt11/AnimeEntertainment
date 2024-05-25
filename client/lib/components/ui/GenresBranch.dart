import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';

class GenresBranch extends StatelessWidget {
  final List<dynamic> genreList;
  const GenresBranch({super.key, required this.genreList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: List.generate(genreList.length, (index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 5),
          child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color.fromARGB(29, 218, 94, 240)),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (rect) => LinearGradient(
                    colors: Utils.gradientColors,
                    begin: Alignment.topCenter,
                  ).createShader(rect),
                  child: Text(
                    genreList[index]['genreName'],
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              )),
        );
      }),
    );
  }
}
