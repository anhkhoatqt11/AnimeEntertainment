import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class CoinButton extends StatelessWidget {
  final Function action;
  const CoinButton({
    super.key,
    required this.action,
  });

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
                height: 40,
                width: 120,
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white),
                ))),
        GestureDetector(
          child: const Row(
            children: [
              FaIcon(
                FontAwesomeIcons.wallet,
                color: Colors.white,
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Nạp ngay",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
          onTap: () => {action()},
        )
      ],
    );
  }
}
