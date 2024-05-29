// ignore_for_file: library_private_types_in_public_api

import 'package:anime_and_comic_entertainment/pages/anime/watch_anime_page.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_test_result_page.dart';
import 'package:anime_and_comic_entertainment/pages/donate/donate_detail_page.dart';
import 'package:anime_and_comic_entertainment/pages/donate/donate_page.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/pages/home/splash.dart';
import 'package:anime_and_comic_entertainment/pages/profile/about_us_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/about_us_privacy.dart';
import 'package:anime_and_comic_entertainment/pages/profile/about_us_tou.dart';
import 'package:anime_and_comic_entertainment/pages/profile/avatar_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/edit_profile_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/payment_history_page.dart';
import 'package:anime_and_comic_entertainment/pages/profile/profile_page.dart';
import 'package:anime_and_comic_entertainment/pages/test.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/providers/comic_detail_provider.dart';
import 'package:anime_and_comic_entertainment/services/firebase_api.dart';
import 'package:anime_and_comic_entertainment/tab_navigator.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_test_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = StripeApiKey.publishableKey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDtoKADEsE3QxNeflKMKcyRIOqzG3eScsA',
          appId: '1:198652970229:android:4e38bd8f3a5553e7f0f1bc',
          messagingSenderId: '198652970229',
          projectId: 'pushnotiflutter-95328'));
  await FirebaseApi().initNotification();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => VideoProvider()),
    ChangeNotifierProvider(create: (context) => MiniPlayerControllerProvider()),
    ChangeNotifierProvider(create: (context) => NavigatorProvider()),
    ChangeNotifierProvider(create: (context) => ComicChapterProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'skylark',
      color: Color(0xFF141414),
      home: TestPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static const double _playerMinHeight = 112.0;
  final autoSizeGroup = AutoSizeGroup();

  final iconList = <IconData>[
    FontAwesomeIcons.house,
    FontAwesomeIcons.bookOpenReader,
    FontAwesomeIcons.clapperboard,
    FontAwesomeIcons.gamepad,
    FontAwesomeIcons.clipboardUser,
  ];

  final titleList = ['Trang chủ', 'Truyện', 'Anime', 'Thử thách', 'Cá nhân'];

  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4", "Page5"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    String cur =
        Provider.of<NavigatorProvider>(context, listen: false).currentPage;
    if (tabItem == cur) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      Provider.of<NavigatorProvider>(context, listen: false)
          .setCurrentPage(pageKeys[index]);
    }
  }

  @override
  void initState() {
    FirebaseApi().listenEvent(context);
    FirebaseApi().storeDeviceToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, value, Widget? child) {
      final isStack = Provider.of<NavigatorProvider>(context).isShowNavigator;
      final bottomIndex =
          Provider.of<NavigatorProvider>(context).bottomIndexNavigator;
      return Scaffold(
        backgroundColor: const Color(0xFF141414),
        body: Consumer(
          builder: (context, watch, _) {
            final anime = Provider.of<VideoProvider>(context).anime;
            final episode = Provider.of<VideoProvider>(context).episode;
            final miniPlayerController =
                Provider.of<MiniPlayerControllerProvider>(context).state;
            return Stack(children: <Widget>[
              _buildOffstageNavigator("Page1"),
              _buildOffstageNavigator("Page2"),
              _buildOffstageNavigator("Page3"),
              _buildOffstageNavigator("Page4"),
              _buildOffstageNavigator("Page5"),
              Offstage(
                offstage: anime.id == null || episode.id == null,
                child: Miniplayer(
                    controller: miniPlayerController,
                    minHeight: _playerMinHeight,
                    maxHeight: MediaQuery.of(context).size.height,
                    builder: (height, percentage) {
                      if (anime.id == null || episode.id == null) {
                        return const SizedBox.shrink();
                      }
                      return WatchAnimePage(
                          animeId: anime.id,
                          videoId: episode.id,
                          height: height,
                          percent: percentage,
                          maxHeight: MediaQuery.of(context).size.height);
                    }),
              ),
            ]);
          },
        ),
        bottomNavigationBar: isStack
            ? AnimatedBottomNavigationBar.builder(
                height: 60,
                itemCount: iconList.length,
                tabBuilder: (int index, bool isActive) {
                  final whiteColors = List<Color>.from([
                    const Color.fromARGB(255, 255, 255, 255),
                    const Color.fromARGB(255, 239, 239, 239)
                  ]);
                  final finalColor =
                      isActive ? Utils.gradientColors : whiteColors;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) => LinearGradient(
                          colors: finalColor,
                          begin: Alignment.topCenter,
                        ).createShader(rect),
                        child: FaIcon(
                          iconList[index],
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ShaderMask(
                          shaderCallback: (rect) => LinearGradient(
                            colors: finalColor,
                            begin: Alignment.topCenter,
                          ).createShader(rect),
                          child: Text(
                            titleList[index],
                            maxLines: 1,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 10),
                            // group: autoSizeGroup,
                          ),
                        ),
                      )
                    ],
                  );
                },
                backgroundColor: const Color(0XFF2D2D2D),
                activeIndex: bottomIndex,
                splashColor: Utils.accentColor,
                splashSpeedInMilliseconds: 0,
                notchSmoothness: NotchSmoothness.defaultEdge,
                gapLocation: GapLocation.none,
                leftCornerRadius: 24,
                rightCornerRadius: 24,
                // onTap: (index) => setState(() => _bottomNavIndex = index),
                onTap: (index) => {
                      if (Provider.of<MiniPlayerControllerProvider>(context,
                              listen: false)
                          .isMax)
                        {
                          Provider.of<MiniPlayerControllerProvider>(context,
                                  listen: false)
                              .setMiniController(PanelState.MIN)
                        },
                      setState(() => _selectTab(pageKeys[index], index)),
                      Provider.of<NavigatorProvider>(context, listen: false)
                          .setNavagatorIndex(index)
                    })
            : const SizedBox.shrink(),
      );
    });
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Consumer(
      builder: (context, watch, _) {
        String cur =
            Provider.of<NavigatorProvider>(context, listen: false).currentPage;
        return Offstage(
          offstage: cur != tabItem,
          child: TabNavigator(
            navigatorKey: _navigatorKeys[tabItem]!,
            tabItem: tabItem,
          ),
        );
      },
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    print("Restart");
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
