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
      backgroundColor: const Color(0xFF141414),
      contentTextStyle: const TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Row(
        children: [
          Image.asset(
            "assets/images/logoImage.png",
            height: 24,
            width: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
                color: Utils.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
      content: Text(content),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GFButton(
              text: "OK",
              type: GFButtonType.outline,
              color: Utils.primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
                action();
              },
            ),
          ],
        )
      ],
      elevation: 12,
    );
  }
}
