import 'package:anime_and_comic_entertainment/components/challenge/DailyLoginGift.dart';
import 'package:anime_and_comic_entertainment/components/ui/ReceivedCoinDialog.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/daily_quests_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyLoginList extends StatefulWidget {
  final int giftPrize;
  const DailyLoginList({super.key, required this.giftPrize});

  @override
  State<DailyLoginList> createState() => _DailyLoginListState();
}

class _DailyLoginListState extends State<DailyLoginList> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, value, Widget? child) {
      final user = Provider.of<UserProvider>(context).user;
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Wrap(
            children: List.generate(7, (index) {
          int currentIndex = (DateTime.now().weekday);
          return GestureDetector(
              onTap: () async {
                if (currentIndex == index + 1 &&
                    user.authentication["sessionToken"] != "" &&
                    !user.questLog["hasReceivedDailyGift"]) {
                  await DailyQuestsApi.updateLoginLog(context);
                  showDialog(
                      context: context,
                      builder: (_) => ReceivedCoinDialog(
                            content:
                                "Chúc mừng bạn đã nhận được ${widget.giftPrize} skycoins",
                          ));
                }
              },
              child: DailyLoginGift(
                day: convertIndexDayToName(index),
                prize: widget.giftPrize,
                color: convertIndexDayToColor(index + 1, currentIndex,
                    user.questLog["hasReceivedDailyGift"]),
              ));
        })),
      );
    });
  }
}

String convertIndexDayToName(int value) {
  return value == 6 ? "Chủ nhật" : "Thứ ${value + 2}";
}

Color convertIndexDayToColor(int value, int current, bool received) {
  return value < current
      ? const Color(0xFF4A4A4A)
      : value > current
          ? const Color(0XFF2A2A2F)
          : value == current && !received
              ? Utils.primaryColor
              : const Color(0xFF4A4A4A);
}
