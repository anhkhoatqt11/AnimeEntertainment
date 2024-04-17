import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomAlertChoiceDialog extends StatelessWidget {
  final String content;
  final String title;
  final Function action;
  const CustomAlertChoiceDialog(
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
          children: [
            Expanded(
              child: GFButton(
                text: "Đăng xuất",
                type: GFButtonType.outline,
                color: Utils.primaryColor,
                onPressed: () {
                  action();
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: GFButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: "Bỏ qua",
                color: Utils.primaryColor,
                type: GFButtonType.solid,
              ),
            ),
          ],
        )
      ],
      elevation: 12,
    );
  }
}
