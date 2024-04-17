import 'dart:async';
import 'package:anime_and_comic_entertainment/main.dart';
import 'package:anime_and_comic_entertainment/pages/test.dart';
import 'package:anime_and_comic_entertainment/services/auth_api.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTimer();
    AuthApi.getLogin(context);
  }

  startTimer() {
    var duration = Duration(seconds: 5, milliseconds: 0);
    return Timer(duration, route);
  }

  route() {
    // Navigator.pushReplacementNamed(context, '/home');
    Navigator.of(context).pushReplacement(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => TestPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 2.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xFF141414),
      child: Center(
        child: Image.asset(
          'assets/images/skylarkgif.gif',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
