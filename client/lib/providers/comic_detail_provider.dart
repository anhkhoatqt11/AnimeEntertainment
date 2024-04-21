import 'package:anime_and_comic_entertainment/model/comics.dart';
import 'package:anime_and_comic_entertainment/services/comics_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComisDetailProvider extends ChangeNotifier {
  Comics? comis;
  String? email;

  Future<void> getListCosmic(String comicId) async {
    comis = await ComicsApi.getComicDetailById(comicId);
    print(comis);
    notifyListeners();
  }
}
