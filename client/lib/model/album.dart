import 'package:anime_and_comic_entertainment/model/animes.dart';

class ComicAlbum {
  final String? id;
  final String? albumName;
  final List? comicList;

  ComicAlbum({this.id, this.albumName, this.comicList});
}

class AnimeAlbum {
  final String? id;
  final String? albumName;
  final List? animeList;

  AnimeAlbum({this.id, this.albumName, this.animeList});
}
