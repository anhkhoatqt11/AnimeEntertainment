import 'dart:ffi';

class Comics {
  // final String? _id;
  final String? coverImage;
  final String? comicName;
  final String? author;
  final String? artist;
  final List? genres;
  final String? ageFor;
  final String? publisher;
  final String? description;
  final String? newChapterTime;
  final List? chapterList;

  Comics(
      // this._id,
      {this.coverImage,
      this.comicName,
      this.author,
      this.artist,
      this.genres,
      this.ageFor,
      this.publisher,
      this.description,
      this.newChapterTime,
      this.chapterList});
}
