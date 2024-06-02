class AnimeEpisodes {
  final String? id;
  final String? coverImage;
  final String? episodeName;
  final int? totalTime;
  final DateTime? publicTime;
  final String? content;
  final List? comments;
  final List? likes;
  final int? views;
  final String? advertising;
  final String? adLink;
  final String? movieOwner;
  final String? movieOwnerId;
  final List? genreNames;

  AnimeEpisodes(
      {this.id,
      this.coverImage,
      this.episodeName,
      this.totalTime,
      this.publicTime,
      this.content,
      this.comments,
      this.likes,
      this.views,
      this.advertising,
      this.adLink,
      this.movieOwner,
      this.movieOwnerId,
      this.genreNames});
}
