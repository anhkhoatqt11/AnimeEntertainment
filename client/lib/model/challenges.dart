import 'package:intl/intl.dart';

class ChallengeQuestion {
  final String id;
  final String questionName;
  final List<dynamic> answers;
  final int correctAnswerID;
  final String mediaUrl;

  ChallengeQuestion({
    required this.id,
    required this.questionName,
    required this.answers,
    required this.correctAnswerID,
    required this.mediaUrl,
  });
}

class UserChallenge {
  final String userId;
  final String name;
  final String avatar;
  final List<Point> points;

  UserChallenge({
    required this.userId,
    required this.name,
    required this.avatar,
    required this.points,
  });

  factory UserChallenge.fromJson(Map<String, dynamic> json) {
    var list = json['point'] as List;
    List<Point> pointsList = list.map((i) => Point.fromJson(i)).toList();
    return UserChallenge(
      userId: json['userId'],
      name: json['name'],
      avatar: json['avatar'],
      points: pointsList,
    );
  }

  // Aggregate points by week
  Map<String, int> getWeeklyPoints() {
    Map<String, int> weeklyPoints = {};
    DateFormat formatter = DateFormat('yyyy-ww');

    for (var p in points) {
      String week = formatter.format(p.date);

      if (weeklyPoints.containsKey(week)) {
        weeklyPoints[week] = weeklyPoints[week]! + p.point;
      } else {
        weeklyPoints[week] = p.point;
      }
    }

    return weeklyPoints;
  }

  int getMaxWeeklyPoints() {
    int maxPoints = 0;
    Map<String, int> weeklyPoints = getWeeklyPoints();
    weeklyPoints.forEach((week, points) {
      if (points > maxPoints) {
        maxPoints = points;
      }
    });
    return maxPoints;
  }
}

class Point {
  final DateTime date;
  final int point;
  final int time;

  Point({required this.date, required this.point, required this.time});

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      date: DateTime.parse(json['date']),
      point: json['point'],
      time: json['time'],
    );
  }
}
