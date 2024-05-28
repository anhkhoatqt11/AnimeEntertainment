import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomAlertDialog extends StatelessWidget {
  final String content;
  final String title;
  final Function action;
  const CustomAlertDialog(
      {super.key,
      required this.content,
      required this.title,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF2A2A2A),
      surfaceTintColor: Colors.transparent,
      contentTextStyle: const TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
      actionsPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logoImage.png",
            height: 32,
            width: 32,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      content: Text(
        content,
        style: const TextStyle(
            color: Color(0xFFD2D2D2), height: 1.3, fontSize: 14),
        textAlign: TextAlign.center,
      ),
      actions: [
        SizedBox(
          height: 50,
          child: Column(
            children: [
              const Divider(
                thickness: .5,
                color: Color(0xFFFFFFFF),
                indent: 0,
                endIndent: 0,
                height: .5,
              ),
              SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                      child: GFButton(
                        text: "OK",
                        type: GFButtonType.transparent,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                          action();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
      elevation: 12,
    );
  }
}
