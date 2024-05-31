import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CoinButton extends StatelessWidget {
  final Function action;

  const CoinButton({
    Key? key,
    required this.action,
  }) : super(key: key);

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
                color: Colors.white,
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => action(),
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent), // Hides the press animation
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.transparent), // Makes background transparent
            elevation: MaterialStateProperty.resolveWith(
                (states) => 0), // Removes shadow
            padding: MaterialStateProperty.all(
                EdgeInsets.zero), // Removes default padding
          ),
          child: Row(
            children: const [
              FaIcon(
                FontAwesomeIcons.wallet,
                color: Colors.white,
                size: 14,
              ),
              SizedBox(width: 5),
              Text(
                "Nạp ngay",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
