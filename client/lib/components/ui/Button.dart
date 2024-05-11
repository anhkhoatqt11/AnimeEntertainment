import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String content;
  final Function action;
  final double height;
  final double width;
  final bool disabled;
  const GradientButton(
      {required this.content,
      required this.action,
      required this.height,
      required this.width,
      required this.disabled});

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
                  onPressed: disabled
                      ? null
                      : () {
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
          onTap: disabled ? null : () => {action()},
        )
      ],
    );
  }
}

class GradientSquareButton extends StatelessWidget {
  final String content;
  final Function action;
  final double height;
  final double width;
  final double cornerRadius;
  const GradientSquareButton(
      {required this.content,
      required this.action,
      required this.height,
      required this.width,
      required this.cornerRadius});

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
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: null,
                ))),
        GestureDetector(
          child: Text(
            content,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          onTap: () => {action()},
        )
      ],
    );
  }
}
