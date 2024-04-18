import 'dart:convert';

import 'package:anime_and_comic_entertainment/model/challenges.dart';
import 'package:anime_and_comic_entertainment/pages/home/no_internet_page.dart';
import 'package:anime_and_comic_entertainment/providers/navigator_provider.dart';
import 'package:anime_and_comic_entertainment/utils/apiKey.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ChallengesApi {
  static const baseUrl = "${UrlApi.urlLocalHost}/api/challenges/";

  static Future<List<ChallengeQuestion>> getChallengesQuestion(
      BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getChallengeQuestions",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = jsonDecode(res.body);
        List<ChallengeQuestion> questionArray = [];
        result.forEach((element) {
          questionArray.add(ChallengeQuestion(
            id: element['_id'],
            questionName: element['questionName'],
            answers: (element['answers'] as List)
                .map((answerJson) => Answer.fromJson(answerJson))
                .toList(),
            correctAnswerID: element['correctAnswerID'],
            mediaUrl: element['mediaUrl'],
          ));
        });
        return questionArray;
      } else {
        return []; // Return an empty list if there's no data
      }
    } catch (e) {
      print(Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError);
      if (Provider.of<NavigatorProvider>(context, listen: false)
              .isShowNetworkError ==
          false) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
      // Return an empty list in case of an error
      return [];
    }
  }
}
