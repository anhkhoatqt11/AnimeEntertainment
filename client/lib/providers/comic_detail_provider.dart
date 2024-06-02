import 'package:anime_and_comic_entertainment/model/comicchapters.dart';
import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/material.dart';

class ComicChapterProvider extends ChangeNotifier {
  Comics _comic = Comics();
  ComicChapter _chapter = ComicChapter();
  bool _hadLiked = false;
  bool _hadSaved = false;

  Comics get comic => _comic;
  ComicChapter get chapter => _chapter;
  bool get hadLiked => _hadLiked;
  bool get hadSaved => _hadSaved;
  void setComic(Comics item, ComicChapter item2) {
    _comic = Comics();
    _chapter = ComicChapter();
    notifyListeners();
    Future.delayed(const Duration(microseconds: 100), () {
      _comic = item;
      _chapter = item2;
      notifyListeners(); // Prints after 1 second.
    });
  }

  Future<void> setLikeSave(String userId, BuildContext context) async {
    if (_comic.id == null || _chapter.id == null) return;
    var result = await ComicsApi.checkUserHasLikeOrSaveChapter(
        context, _chapter.id, userId);
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
