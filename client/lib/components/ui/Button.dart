import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';

class GradientButton extends StatelessWidget {
  final String content;
  final Function action;
  final double height;
  final double width;
  const GradientButton(
      {required this.content,
      required this.action,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        ShaderMask(
            shaderCallback: (rect) => LinearGradient(
                  colors: Utils.gradientColors,
                  begin: Alignment.topCenter,
                ).createShader(rect),
            child: SizedBox(
                height: height,
                width: width,
                child: ElevatedButton(
                  onPressed: () {
                    action();
                  },
                  child: null,
                ))),
        GestureDetector(
          child: Text(
            content,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          onTap: () => {action()},
        )
      ],
    );
  }
}
