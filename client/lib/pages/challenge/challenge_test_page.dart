import 'dart:async';

import 'package:anime_and_comic_entertainment/components/challenge/AnswerOption.dart';
import 'package:anime_and_comic_entertainment/model/challenges.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_test_result_page.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/challenges_api.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:provider/provider.dart';

class ChallengeTest extends StatefulWidget {
  const ChallengeTest({Key? key}) : super(key: key);

  @override
  State<ChallengeTest> createState() => _ChallengeTestState();
}

class _ChallengeTestState extends State<ChallengeTest> {
  //Define data
  List<ChallengeQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  Map<int, int?> _userAnswers = {};
  int _score = 0;
  late Timer _timer;
  int _timerDurationInSeconds = 300; // 5 minutes
  late String userId = "";
  bool _answerSelected = false; // Track if an answer is selected

  Future<void> getUserID() async {
    userId = Provider.of<UserProvider>(context, listen: false).user.id;
    print(userId);
    return;
  }

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    _startTimer();
    getUserID();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_timerDurationInSeconds > 0) {
          _timerDurationInSeconds--;
        } else {
          timer.cancel();
          _submitAnswer();
        }
      });
    });
  }

  Future<void> _fetchQuestions() async {
    var result = await ChallengesApi.getChallengesQuestion(context);
    setState(() {
      _questions = result;
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _answerSelected = false; // Reset answer selection for next question
      }
      print(_userAnswers);
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentQuestionIndex > 0) {
        _currentQuestionIndex--;
      }
    });
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _userAnswers[_currentQuestionIndex] = answerIndex;
      _answerSelected = true; // Set answer selected to true
    });
  }

  void _submitAnswer() {
    if (!_answerSelected) {
      // Don't submit if no answer is selected
      return;
    }
    int correctAnswers = 0;
    int totalBonusPoints = 0;
    List<String> userAnswers = [];
    List<bool> isCorrect = [];

    for (int i = 0; i < _questions.length; i++) {
      int? userAnswerIndex = _userAnswers[i];
      int correctAnswerIndex = _questions[i].correctAnswerID;

      if (userAnswerIndex != null) {
        if (userAnswerIndex == correctAnswerIndex) {
          correctAnswers++;
          isCorrect.add(true);
        } else {
          isCorrect.add(false);
        }
        userAnswers.add(_questions[i].answers[userAnswerIndex].content);
      }
    }

    int timeBonus =
        ((_timerDurationInSeconds / 60).toInt() * 20).clamp(0, 1000);

    // Calculate total points
    int questionPoints = correctAnswers * 100;
    int totalPoints = questionPoints + timeBonus;

    // Ensure total points don't exceed 1000
    int score = totalPoints > 1000 ? 1000 : totalPoints;

    //Push user result to database
    ChallengesApi.uploadUsersChallengesPoint(
      userId: userId,
      point: totalPoints,
      date: DateTime.now(),
      remainingTime: _timerDurationInSeconds,
    );

    // Navigate to result page and pass data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeTestResult(
          userAnswers: userAnswers,
          isCorrect: isCorrect,
          totalPoints: score,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions == null || _questions.isEmpty) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    ChallengeQuestion question = _questions[_currentQuestionIndex];

    String minutes = (_timerDurationInSeconds ~/ 60).toString().padLeft(2, '0');
    String seconds = (_timerDurationInSeconds % 60).toString().padLeft(2, '0');
    String timeText = '$minutes:$seconds';

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: GFAppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF141414),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thử thách",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Câu hỏi tuần này",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "${_currentQuestionIndex + 1}/${_questions.length}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  '$timeText',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  question.mediaUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: Text(
              question.questionName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < question.answers.length; i += 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _selectAnswer(i),
                      child: AnswerOption(
                        text: question.answers[i].content,
                        color: _userAnswers[_currentQuestionIndex] == i
                            ? Colors.red
                            : Colors.blue, // Change color based on selection
                      ),
                    ),
                    if (i + 1 < question.answers.length)
                      GestureDetector(
                        onTap: () => _selectAnswer(i + 1),
                        child: AnswerOption(
                          text: question.answers[i + 1].content,
                          color: _userAnswers[_currentQuestionIndex] == i + 1
                              ? Colors.red
                              : Colors.blue, // Change color based on selection
                        ),
                      ),
                  ],
                ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _previousQuestion,
                    child: const Text('Trở lại'),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_answerSelected) {
                        // Only proceed if an answer is selected
                        if (_currentQuestionIndex == _questions.length - 1) {
                          _submitAnswer();
                          print("User Answers: $_userAnswers");
                        } else {
                          _nextQuestion();
                        }
                      }
                    },
                    child: _currentQuestionIndex == _questions.length - 1
                        ? const Text('Hoàn thành')
                        : const Text('Tiếp theo'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
