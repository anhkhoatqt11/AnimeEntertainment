class ChallengeQuestion {
  final String id;
  final String questionName;
  final List<Answer> answers;
  final int correctAnswerID;
  final String mediaUrl;

  ChallengeQuestion({
    required this.id,
    required this.questionName,
    required this.answers,
    required this.correctAnswerID,
    required this.mediaUrl,
  });

  factory ChallengeQuestion.fromJson(Map<String, dynamic> json) {
    return ChallengeQuestion(
      id: json['_id'],
      questionName: json['questionName'],
      answers: (json['answers'] as List)
          .map((answerJson) => Answer.fromJson(answerJson))
          .toList(),
      correctAnswerID: json['correctAnswerID'],
      mediaUrl: json['mediaUrl'],
    );
  }
}

class Answer {
  final String content;

  Answer({
    required this.content,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      content: json['content'],
    );
  }
}

class UserChallenge {
  final String userId;
  final String name;
  final String avatar;
  final List<Map<String, dynamic>> point;

  UserChallenge({
    required this.userId,
    required this.name,
    required this.avatar,
    required this.point,
  });

  factory UserChallenge.fromJson(Map<String, dynamic> json) {
    // Parse the 'point' field as a List<Map<String, dynamic>>
    List<Map<String, dynamic>> points = [];
    if (json['point'] != null) {
      points = List<Map<String, dynamic>>.from(json['point']);
    }

    return UserChallenge(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      point: points, // Assign the parsed 'points' list
    );
  }

  int getMaxTime() {
    int maxTime = 0;
    for (var p in point) {
      int currentTime = p['time'] ?? 0;
      if (currentTime > maxTime) {
        maxTime = currentTime;
      }
    }
    return maxTime;
  }
}
