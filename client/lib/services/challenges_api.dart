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
            id: element['questionId'],
            questionName: element['questionName'],
            answers: element['answers'],
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
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
      // Return an empty list in case of an error
      return [];
    }
  }

  static getChallegenInformation(BuildContext context) async {
    var url = Uri.parse(
      "${baseUrl}getChallengeInformation",
    );
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var result = (jsonDecode(res.body));
        var information = {
          "challengeName": result['challengeName'],
          "endTime": result['endTime']
        };
        return information;
      } else {
        return [];
      }
    } catch (e) {
      print(Provider.of<NavigatorProvider>(context, listen: false)
          .isShowNetworkError);
      if (Provider.of<NavigatorProvider>(context, listen: false)
              .isShowNetworkError ==
          false) {
        Provider.of<NavigatorProvider>(context, listen: false)
            .setShowNetworkError(true, 0, "Page1");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoInternetPage()));
      }
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

  static Future<List<UserChallenge>> getUsersChallengesPoints() async {
    var url = Uri.parse("${baseUrl}getUsersChallengesPoint");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        List<UserChallenge> userChallenges = [];
        for (var item in data) {
          userChallenges.add(UserChallenge.fromJson(item));
        }
        return userChallenges;
      } else {
        return []; // Return an empty list if there's no data
      }
    } catch (e) {
      print('Error fetching leaderboard: $e');
      throw Exception('Error: $e');
    }
  }

  // static Future<UserChallenge?> getUserCurrentPosition(String userId) async {
  //   try {
  //     List<UserChallenge> userChallenges = await getUsersChallengesPoints();
  //     UserChallenge? currentUser;
  //     List<UserChallenge> currentWeekChallenges = [];

  //     DateTime now = DateTime.now();
  //     DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  //     DateTime endOfWeek =
  //         now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

  //     for (var user in userChallenges) {
  //       var weeklyPoints = user.points.where((point) {
  //         return point.date.isAfter(startOfWeek) &&
  //             point.date.isBefore(endOfWeek);
  //       }).toList();

  //       if (weeklyPoints.isNotEmpty) {
  //         var totalPoints =
  //             weeklyPoints.fold<int>(0, (sum, item) => sum + item.point);
  //         var totalTime =
  //             weeklyPoints.fold<int>(0, (sum, item) => sum + item.time);

  //         currentWeekChallenges.add(UserChallenge(
  //           userId: user.userId,
  //           name: user.name,
  //           avatar: user.avatar,
  //           points: [
  //             Point(date: DateTime.now(), point: totalPoints, time: totalTime)
  //           ],
  //         ));

  //         if (user.userId == userId) {
  //           currentUser = UserChallenge(
  //             userId: user.userId,
  //             name: user.name,
  //             avatar: user.avatar,
  //             points: [
  //               Point(date: DateTime.now(), point: totalPoints, time: totalTime)
  //             ],
  //           );
  //         }
  //       }
  //     }

  //     currentWeekChallenges.sort((a, b) {
  //       var pointComparison =
  //           b.points.first.point.compareTo(a.points.first.point);
  //       if (pointComparison != 0) {
  //         return pointComparison;
  //       } else {
  //         return b.points.first.time.compareTo(a.points.first.time);
  //       }
  //     });

  //     return currentUser;
  //   } catch (e) {
  //     print('Error fetching user current position: $e');
  //     throw Exception('Error: $e');
  //   }
  // }
  static Future<int> getUserCurrentPosition(String userId) async {
    var url = Uri.parse("${baseUrl}getUsersChallengesPoint");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        List<UserChallenge> userChallenges = [];
        for (var item in data) {
          userChallenges.add(UserChallenge.fromJson(item));
        }
        // Sort the userChallenges list based on max weekly points
        userChallenges.sort(
            (a, b) => b.getMaxWeeklyPoints().compareTo(a.getMaxWeeklyPoints()));
        // Find the position of the user
        for (int i = 0; i < userChallenges.length; i++) {
          if (userChallenges[i].userId == userId) {
            return i + 1; // Position is index + 1
          }
        }
        return -1; // User not found
      } else {
        throw Exception('Failed to load user challenges');
      }
    } catch (e) {
      print('Error fetching user position: $e');
      throw Exception('Error: $e');
    }
  }
}
