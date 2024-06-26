import 'dart:ffi';

class Animes {
  final String? id;
  final String? coverImage;
  final String? landspaceImage;
  final String? movieName;
  final List? genres;
  final String? publishTime;
  final String? ageFor;
  final String? publisher;
  final String? description;
  final List? genreNames;
  final List? episodes;
  final int? totalView;
  final int? totalLike;

  Animes(
      {this.id,
      this.coverImage,
      this.landspaceImage,
      this.movieName,
      this.genres,
      this.publishTime,
      this.ageFor,
      this.publisher,
      this.description,
      this.genreNames,
      this.episodes,
      this.totalView,
      this.totalLike});
}
