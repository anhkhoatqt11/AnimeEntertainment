import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ReceivedCoinDialog extends StatelessWidget {
  final String content;
  const ReceivedCoinDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      contentTextStyle: const TextStyle(color: Colors.white),
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      actionsPadding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: SizedBox(
        height: 340,
        child: Column(
          children: [
            Image.asset(
              "assets/images/receivedcoin.gif",
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.red[400]!),
                ),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GFButton(
              text: "OK",
              type: GFButtonType.solid,
              color: Utils.primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      elevation: 12,
    );
  }
}
