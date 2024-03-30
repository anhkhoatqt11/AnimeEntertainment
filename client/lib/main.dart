// ignore_for_file: library_private_types_in_public_api

import 'package:anime_and_comic_entertainment/components/animes/VideoComponent.dart';
import 'package:anime_and_comic_entertainment/model/animes.dart';
import 'package:anime_and_comic_entertainment/pages/anime/anime_page.dart';
import 'package:anime_and_comic_entertainment/pages/anime/detail_anime_page.dart';
import 'package:anime_and_comic_entertainment/pages/anime/tabview.dart';
import 'package:anime_and_comic_entertainment/pages/anime/watch_anime_page.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_page.dart';
import 'package:anime_and_comic_entertainment/pages/comic/comic_page.dart';
import 'package:anime_and_comic_entertainment/pages/home/home_page.dart';
import 'package:anime_and_comic_entertainment/pages/payment.dart';
import 'package:anime_and_comic_entertainment/pages/profile/profile_page.dart';
import 'package:anime_and_comic_entertainment/pages/test.dart';
import 'package:anime_and_comic_entertainment/pages/auth/profile.dart';
import 'package:anime_and_comic_entertainment/pages/home/splash.dart';
import 'package:anime_and_comic_entertainment/providers/mini_player_controller_provider.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/providers/video_provider.dart';
import 'package:anime_and_comic_entertainment/tab_navigator.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = StripeApiKey.publishableKey;
  await Stripe.instance.applySettings();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => VideoProvider()),
    ChangeNotifierProvider(create: (context) => MiniPlayerControllerProvider())
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
        color: const Color(0xFF141414),
        home: MyHomePage(
          title: '',
        ));
  }
}

// set up navigation here --------------------------------------------------------------- //

// class NavigationScreen extends StatefulWidget {
//   final int navIndex;

//   NavigationScreen(this.navIndex) : super();

//   @override
//   _NavigationScreenState createState() => _NavigationScreenState();
// }

// class _NavigationScreenState extends State<NavigationScreen>
//     with TickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//   }
//   // right here ...

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color(0xFF141414),
//       child: widget.navIndex == 0
//           ? HomePage()
//           : widget.navIndex == 1
//               ? ComicPage()
//               : widget.navIndex == 2
//                   ? AnimePage()
//                   : widget.navIndex == 3
//                       ? ChallengePage()
//                       : ProfilePage(),
//     );
//   }
// }

// ------------------------------------------------------------------------------------- //

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static const double _playerMinHeight = 112.0;
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  final iconList = <IconData>[
    FontAwesomeIcons.house,
    FontAwesomeIcons.bookOpenReader,
    FontAwesomeIcons.clapperboard,
    FontAwesomeIcons.gamepad,
    FontAwesomeIcons.clipboardUser,
  ];

  final titleList = ['Trang chủ', 'Truyện', 'Anime', 'Thử thách', 'Cá nhân'];

  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3", "Page4", "Page5"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
    "Page5": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: Consumer(
        builder: (context, watch, _) {
          final res = Provider.of<VideoProvider>(context).anime;
          final miniPlayerController =
              Provider.of<MiniPlayerControllerProvider>(context).state;

          return Stack(children: <Widget>[
            _buildOffstageNavigator("Page1"),
            _buildOffstageNavigator("Page2"),
            _buildOffstageNavigator("Page3"),
            _buildOffstageNavigator("Page4"),
            _buildOffstageNavigator("Page5"),
            Offstage(
              offstage: res.id == null,
              child: Miniplayer(
                  controller: miniPlayerController,
                  minHeight: _playerMinHeight,
                  maxHeight: MediaQuery.of(context).size.height,
                  builder: (height, percentage) {
                    if (res.id == null) return const SizedBox.shrink();
                    return WatchAnimePage(
                        videoId: res.id,
                        height: height,
                        percent: percentage,
                        maxHeight: MediaQuery.of(context).size.height);
                  }),
            ),
          ]);
        },
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          height: 60,
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final whiteColors = List<Color>.from([
              const Color.fromARGB(255, 255, 255, 255),
              const Color.fromARGB(255, 239, 239, 239)
            ]);
            final finalColor = isActive ? Utils.gradientColors : whiteColors;
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
          activeIndex: _bottomNavIndex,
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
                setState(() {
                  _bottomNavIndex = index;
                })
              }),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Color(0xFF141414),
  //     extendBody: true,
  //     body: NotificationListener<ScrollNotification>(
  //       child: NavigationScreen(_bottomNavIndex),
  //     ),
  //     bottomNavigationBar: AnimatedBottomNavigationBar.builder(
  //       height: 60,
  //       itemCount: iconList.length,
  //       tabBuilder: (int index, bool isActive) {
  //         final whiteColors = List<Color>.from([
  //           Color.fromARGB(255, 255, 255, 255),
  //           Color.fromARGB(255, 239, 239, 239)
  //         ]);
  //         final finalColor = isActive ? Utils.gradientColors : whiteColors;
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             ShaderMask(
  //               shaderCallback: (rect) => LinearGradient(
  //                 colors: finalColor,
  //                 begin: Alignment.topCenter,
  //               ).createShader(rect),
  //               child: FaIcon(
  //                 iconList[index],
  //                 color: Colors.white,
  //                 size: 20,
  //               ),
  //             ),
  //             const SizedBox(height: 2),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 8),
  //               child: ShaderMask(
  //                 shaderCallback: (rect) => LinearGradient(
  //                   colors: finalColor,
  //                   begin: Alignment.topCenter,
  //                 ).createShader(rect),
  //                 child: Text(
  //                   titleList[index],
  //                   maxLines: 1,
  //                   style: const TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.w500,
  //                       fontSize: 10),
  //                   // group: autoSizeGroup,
  //                 ),
  //               ),
  //             )
  //           ],
  //         );
  //       },
  //       backgroundColor: const Color(0XFF2D2D2D),
  //       activeIndex: _bottomNavIndex,
  //       splashColor: Utils.accentColor,
  //       splashSpeedInMilliseconds: 0,
  //       notchSmoothness: NotchSmoothness.defaultEdge,
  //       gapLocation: GapLocation.none,
  //       leftCornerRadius: 24,
  //       rightCornerRadius: 24,
  //       onTap: (index) => setState(() => _bottomNavIndex = index),
  //     ),
  //   );
  // }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
