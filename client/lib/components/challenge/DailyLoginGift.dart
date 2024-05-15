import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';

class DailyLoginGift extends StatelessWidget {
  final String day;
  final int prize;
  final Color color;
  const DailyLoginGift(
      {super.key, required this.day, required this.prize, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 50,
        height: 50,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Text(
              day,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
            ),
            Image.asset(
              "assets/images/skycoin.png",
              width: 16,
              height: 16,
            ),
            Text(
              "x$prize",
              style: TextStyle(
                  color: color == Utils.primaryColor
                      ? Colors.white
                      : Colors.orange,
                  fontWeight: FontWeight.w500,
                  fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}
