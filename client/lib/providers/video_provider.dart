import 'package:anime_and_comic_entertainment/model/animeepisodes.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/services/animes_api.dart';
import 'package:flutter/material.dart';

class VideoProvider extends ChangeNotifier {
  Animes _anime = Animes();
  AnimeEpisodes _episode = AnimeEpisodes();
  bool _hadLiked = false;
  bool _hadSaved = false;

  Animes get anime => _anime;
  AnimeEpisodes get episode => _episode;
  bool get hadLiked => _hadLiked;
  bool get hadSaved => _hadSaved;
  void setAnime(Animes item, AnimeEpisodes item2) {
    _anime = Animes();
    _episode = AnimeEpisodes();
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      print("allo");
      _anime = item;
      _episode = item2;
      notifyListeners(); // Prints after 1 second.
    });
  }

  Future<void> setLikeSave(String userId, BuildContext context) async {
    if (_anime.id == null || _episode.id == null) return;
    var result = await AnimesApi.checkUserHasLikeOrSaveEpisode(
        context, _episode.id, userId);
    _hadLiked = result['like'];
    _hadSaved = result['bookmark'];
    notifyListeners();
  }

  void setLiked() {
    _hadLiked = !_hadLiked;
    notifyListeners();
  }

  void setSaved() {
    _hadSaved = !_hadSaved;
    notifyListeners();
  }
}
