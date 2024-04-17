import 'package:anime_and_comic_entertainment/pages/anime/anime_page.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_page.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_page.dart';
import 'package:anime_and_comic_entertainment/pages/home/home_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => tabItem == "Page1"
                ? HomePage()
                : tabItem == "Page2"
                    ? ComicPage()
                    : tabItem == "Page3"
                        ? AnimePage()
                        : tabItem == "Page4"
                            ? ChallengePage()
                            : ProfilePage());
      },
    );
  }
}
