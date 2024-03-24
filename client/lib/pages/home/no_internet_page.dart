import 'dart:ui';

import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/types/gf_button_type.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GFAppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: GFIconButton(
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            type: GFButtonType.transparent,
          ),
        ),
        body: Stack(alignment: AlignmentDirectional.center, children: [
          Image.asset(
            'assets/images/comiclist.jpg',
            height: double.infinity,
            width: double.infinity,
            repeat: ImageRepeat.repeatY,
          ),
          Opacity(
            opacity: 0.8,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/error_network.png',
                  height: 200,
                  width: 200,
                ),
                ShaderMask(
                    shaderCallback: (rect) => LinearGradient(
                          colors: Utils.gradientColors,
                          begin: Alignment.topCenter,
                        ).createShader(rect),
                    child: const Text(
                      "500 - Lỗi mạng",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Vui lòng kiểm tra đường truyền mạng để tiếp tục trải nghiệm",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}
