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

  static Future<void> uploadUsersChallengesPoint({
    required String userId,
    required int point,
    required DateTime date,
    required int remainingTime,
  }) async {
    var url = Uri.parse("${baseUrl}uploadUsersChallengesPoint");
    try {
      final res = await http.post(
        url,
        body: jsonEncode({
          'userId': userId,
          'point': point,
          'date': date.toIso8601String(), // Convert DateTime to ISO 8601 string
          'remainingTime': remainingTime,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (res.statusCode == 200) {
        // Success
        print('User challenge points uploaded successfully');
      } else {
        // Handle other status codes
        print('Failed to upload user challenge points: ${res.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error uploading user challenge points: $e');
    }
  }

  static Future<List<UserChallenge>> getUsersChallengesPoints(
      ) async {
    var url = Uri.parse("${baseUrl}getUsersChallengesPoint");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        List<UserChallenge> userChallenges = [];
        for (var item in data) {
          userChallenges.add(UserChallenge.fromJson(item));
        }
        print(data);
        return userChallenges;
        } else {
          return []; // Return an empty list if there's no data
        }
      } catch (e) {
        print('Error fetching leaderboard: $e');
      throw Exception('Error: $e');
    }
  }
}
