import 'package:anime_and_comic_entertainment/pages/anime_home.dart';
import 'package:anime_and_comic_entertainment/pages/auth/get_otp.dart';
import 'package:anime_and_comic_entertainment/pages/auth/otp_verify_page.dart';
import 'package:anime_and_comic_entertainment/pages/auth/password_page.dart';
import 'package:anime_and_comic_entertainment/pages/comic_page.dart';
import 'package:anime_and_comic_entertainment/pages/test.dart';
import 'package:anime_and_comic_entertainment/pages/auth/login.dart';
import 'package:anime_and_comic_entertainment/pages/auth/profile.dart';
import 'package:anime_and_comic_entertainment/pages/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/pages/splash.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/pages/splash.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = StripeApiKey.publishableKey;
  await Stripe.instance.applySettings();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'skylark',
      home: Scaffold(
        body: TestPage(),
      ),
    );
  }
}

// set up navigation here --------------------------------------------------------------- //

class NavigationScreen extends StatefulWidget {
  final int navIndex;

  NavigationScreen(this.navIndex) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }
  // right here ...

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF141414),
      child: widget.navIndex == 1
          ? ComicPage()
          : widget.navIndex == 4
              ? Profile()
              : AnimePage(),
    );
  }
}

// ------------------------------------------------------------------------------------- //
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      extendBody: true,
      body: NotificationListener<ScrollNotification>(
        child: NavigationScreen(_bottomNavIndex),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 60,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final whiteColors = List<Color>.from([
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 239, 239, 239)
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
                    style: TextStyle(
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
        backgroundColor: Color(0XFF2D2D2D),
        activeIndex: _bottomNavIndex,
        splashColor: Utils.accentColor,
        splashSpeedInMilliseconds: 0,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.none,
        leftCornerRadius: 24,
        rightCornerRadius: 24,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
