import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

class ComicChapterComment extends StatelessWidget {
  final String comicId;
  final int chapterIndex;

  const ComicChapterComment(
      {required this.comicId, required this.chapterIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text("Bình luận"),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF141414)),
    );
  }
}
