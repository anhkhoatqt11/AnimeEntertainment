import 'package:anime_and_comic_entertainment/pages/home.dart';
import 'package:anime_and_comic_entertainment/pages/splash.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = StripeApiKey.publishableKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => HomeScreen(),
      },
      home: const HomeScreen(),
    );
  }
}
