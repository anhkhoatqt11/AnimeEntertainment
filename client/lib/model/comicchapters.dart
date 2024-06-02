import 'dart:core';

class ComicChapter {
  final String? id;
  final String? coverImage;
  final String? chapterName;
  final DateTime? publicTime;
  final List? content;
  final List? comments;
  final List? likes;
  final int? views;
  final int? unlockPrice;
  final List? userUnlocked;
  final String? comicOwner;
  final String? comicOwnerId;
  final List? genreNames;
  final int? index;
  final List? comicChapterList;

  ComicChapter(
      {this.id,
      this.coverImage,
      this.chapterName,
      this.publicTime,
      this.content,
      this.comments,
      this.likes,
      this.views,
      this.unlockPrice,
      this.userUnlocked,
      this.comicOwner,
      this.comicOwnerId,
      this.genreNames,
      this.index,
      this.comicChapterList});
}
