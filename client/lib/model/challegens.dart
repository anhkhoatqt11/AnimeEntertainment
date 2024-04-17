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
  final int id;
  final String content;

  Answer({
    required this.id,
    required this.content,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      content: json['content'],
    );
  }
}