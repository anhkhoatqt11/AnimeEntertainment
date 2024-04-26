import 'dart:math';

import 'package:anime_and_comic_entertainment/pages/challenge/challenge_test_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:anime_and_comic_entertainment/components/challenge/Podium.dart';
import 'package:provider/provider.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        appBar: GFAppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF141414),
          title: const Text(
            "Thử thách",
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            GFIconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              onPressed: () {},
              type: GFButtonType.transparent,
            ),
          ],
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Bảng xếp hạng hàng tuần",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Podium(),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 0, 20),
              child: Row(
                children: [
                  const Text(
                    "Chưa có xếp hạng",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                      width: 80), // Add some space between the text and button
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<NavigatorProvider>(context, listen: false)
                          .setShow(false);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChallengeTest()));
                    },
                    child: const Text('Tham gia ngay'),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "Thử thách khác ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ));
  }
}
