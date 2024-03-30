import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/pages/anime/watch_anime_page.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';

class MiniPlayerControllerProvider extends ChangeNotifier {
  final MiniplayerController _miniController = MiniplayerController();
  double _percent = 1.0;
  bool isMax = false;
  // WatchAnimePage animePage = WatchAnimePage(videoId: "");

  MiniplayerController get state => _miniController;
  bool get height => isMax;
  double get percent => _percent;
  // WatchAnimePage get page => animePage;
  void setMiniController(PanelState item) {
    isMax = !isMax;
    _miniController.animateToHeight(state: item);
    notifyListeners();
  }

  void setPercent(double item) {
    _percent = item;
    notifyListeners();
  }
}
