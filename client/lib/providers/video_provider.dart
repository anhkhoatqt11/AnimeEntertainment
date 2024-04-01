import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:flutter/material.dart';

class VideoProvider extends ChangeNotifier {
  Animes _anime = Animes();
  AnimeEpisodes _episode = AnimeEpisodes();

  Animes get anime => _anime;
  AnimeEpisodes get episode => _episode;
  void setAnime(Animes item, AnimeEpisodes item2) {
    _anime = Animes();
    _episode = AnimeEpisodes();
    notifyListeners();
    Future.delayed(const Duration(seconds: 1), () {
      _anime = item;
      _episode = item2;
      notifyListeners(); // Prints after 1 second.
    });
  }
}
