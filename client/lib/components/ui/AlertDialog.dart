import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomAlertDialog extends StatelessWidget {
  final String content;
  final String title;
  final Function action;
  const CustomAlertDialog(
      {required this.content, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Text(content),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GFButton(
              onPressed: () {
                Navigator.of(context).pop();
                action();
              },
              text: "OK",
              color: Color.fromARGB(255, 38, 213, 99),
              shape: GFButtonShape.pills,
              type: GFButtonType.outline2x,
              size: GFSize.LARGE,
            ),
          ],
        )
      ],
      elevation: 12,
      backgroundColor: Colors.white,
    );
  }
}
