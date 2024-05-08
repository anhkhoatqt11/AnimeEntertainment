import 'package:anime_and_comic_entertainment/components/ui/ReceivedCoinDialog.dart';
import 'package:anime_and_comic_entertainment/model/dailyquests.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/daily_quests_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';

class DailyQuestList extends StatefulWidget {
  const DailyQuestList({super.key});

  @override
  State<DailyQuestList> createState() => _DailyQuestListState();
}

class _DailyQuestListState extends State<DailyQuestList> {
  List<DailyQuests> questList = [];
  Future<void> getDailyQuestList() async {
    var result = await DailyQuestsApi.getDailyQuests(context);
    result!.forEach((item) => {
          setState(() {
            questList.add(item);
          })
        });
  }

  bool checkHasReceived(List sample, String item) {
    var result = sample.where((element) => element == item).toList();
    return result.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    getDailyQuestList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, value, Widget? child) {
      final user = Provider.of<UserProvider>(context).user;
      return Column(
        children: List.generate(questList.length, (index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 84,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0XFF2A2A2F)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questList[index].questName!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              "assets/images/skycoin.png",
                              width: 28,
                              height: 28,
                            ),
                            Text(
                              "x${questList[index].prize}",
                              style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                    user.authentication['sessionToken'] != ""
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${questList[index].questType == "reading" ? (user.questLog["readingTime"] > questList[index].requiredTime ? questList[index].requiredTime.toString() : user.questLog["readingTime"].toString()) : (user.questLog["watchingTime"] > questList[index].requiredTime ? questList[index].requiredTime.toString() : user.questLog["watchingTime"].toString())}/${questList[index].requiredTime}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              GFButton(
                                onPressed: () async {
                                  if ((questList[index].questType ==
                                              "reading" &&
                                          user.questLog["readingTime"] <
                                              questList[index].requiredTime) ||
                                      (questList[index].questType ==
                                              "watching" &&
                                          user.questLog["watchingTime"] <
                                              questList[index].requiredTime)) {
                                    return;
                                  }
                                  if (!checkHasReceived(
                                      user.questLog["received"],
                                      questList[index].id!)) {
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setReceived(questList[index].id);
                                    await DailyQuestsApi.updateQuestLog(
                                        context, questList[index].id!);
                                    showDialog(
                                        context: context,
                                        builder: (_) => ReceivedCoinDialog(
                                              content:
                                                  "Chúc mừng bạn đã nhận được ${questList[index].prize} skycoins",
                                            ));
                                  }
                                },
                                color: checkHasReceived(
                                        user.questLog["received"],
                                        questList[index].id!)
                                    ? const Color(0xFF6F6F6F)
                                    : questList[index].questType == "reading"
                                        ? (user.questLog["readingTime"] >=
                                                questList[index].requiredTime
                                            ? Utils.primaryColor
                                            : Color(0xFFE6E4E4))
                                        : (user.questLog["watchingTime"] >=
                                                questList[index].requiredTime
                                            ? Utils.primaryColor
                                            : Color(0xFFE6E4E4)),
                                text: checkHasReceived(
                                        user.questLog["received"],
                                        questList[index].id!)
                                    ? "Đã nhận"
                                    : "Nhận ngay",
                                padding: const EdgeInsets.all(0),
                                type: GFButtonType.solid,
                                size: GFSize.SMALL,
                                textColor:
                                    questList[index].questType == "reading"
                                        ? (user.questLog["readingTime"] >=
                                                questList[index].requiredTime
                                            ? Colors.white
                                            : Colors.black)
                                        : (user.questLog["watchingTime"] >=
                                                questList[index].requiredTime
                                            ? Colors.white
                                            : Colors.black),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
