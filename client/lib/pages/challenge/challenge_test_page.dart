import 'dart:async';

import 'package:anime_and_comic_entertainment/components/challenge/AnswerOption.dart';
import 'package:anime_and_comic_entertainment/components/ui/ReceivedCoinDialog.dart';
import 'package:anime_and_comic_entertainment/model/challenges.dart';
import 'package:anime_and_comic_entertainment/pages/challenge/challenge_test_result_page.dart';
import 'package:anime_and_comic_entertainment/providers/user_provider.dart';
import 'package:anime_and_comic_entertainment/services/challenges_api.dart';
import 'package:anime_and_comic_entertainment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ChallengeTest extends StatefulWidget {
  const ChallengeTest({Key? key}) : super(key: key);

  @override
  State<ChallengeTest> createState() => _ChallengeTestState();
}

class _ChallengeTestState extends State<ChallengeTest> {
  // Define data
  List<ChallengeQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  final Map<int, int?> _userAnswers = {};
  late Timer _timer;
  int _timerDurationInSeconds = 300; // 5 minutes
  late String userId = "";
  bool _answerSelected = false; // Track if an answer is selected

  Future<void> getUserID() async {
    userId = Provider.of<UserProvider>(context, listen: false).user.id;
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
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
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
        userAnswers.add(_questions[i].answers[userAnswerIndex]);
      }
    }

    int timeBonus =
        ((_timerDurationInSeconds / 60).toInt() * 20).clamp(0, 1000);

    // Calculate total points
    int questionPoints = correctAnswers * 100;
    int totalPoints = questionPoints + timeBonus;

    // Ensure total points don't exceed 1000
    int score = totalPoints > 1000 ? 1000 : totalPoints;

    // Push user result to database
    ChallengesApi.uploadUsersChallengesPoint(
      userId: userId,
      point: score,
      date: DateTime.now(),
      remainingTime: _timerDurationInSeconds,
    );

    var setUserProvider = Provider.of<UserProvider>(context, listen: false);

    setUserProvider.setChallenges([
      {"date": DateTime.now(), "point": score, "time": _timerDurationInSeconds}
    ]);

    setUserProvider
        .setCoinPoint(setUserProvider.user.coinPoint + (score / 10).ceil());

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
    if (_questions.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF141414),
        body: Center(
          child: GFLoader(type: GFLoaderType.circle),
        ),
      );
    }

    ChallengeQuestion question = _questions[_currentQuestionIndex];

    String minutes = (_timerDurationInSeconds ~/ 60).toString().padLeft(2, '0');
    String seconds = (_timerDurationInSeconds % 60).toString().padLeft(2, '0');
    String timeText = '$minutes:$seconds';

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Câu hỏi tuần này",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
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
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                timeText != "00:00"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thời gian thêm thưởng",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            timeText,
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: question.mediaUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 200,
                      width: 200,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: Text(
              question.questionName,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < question.answers.length; i += 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => _selectAnswer(i),
                        child: AnswerOption(
                          text: question.answers[i],
                          color: _userAnswers[_currentQuestionIndex] == i
                              ? Utils.primaryColor
                              : i == 0
                                  ? const Color(0xFFEF476F)
                                  : const Color(0xFF06D6A0),
                          textColor: _userAnswers[_currentQuestionIndex] == i
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      if (i + 1 < question.answers.length)
                        GestureDetector(
                          onTap: () => _selectAnswer(i + 1),
                          child: AnswerOption(
                            text: question.answers[i + 1],
                            color: _userAnswers[_currentQuestionIndex] == i + 1
                                ? Utils.primaryColor
                                : i == 0
                                    ? const Color(0XFFFFD166)
                                    : const Color(0XFF00BBF9),
                            textColor:
                                _userAnswers[_currentQuestionIndex] == i + 1
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GFButton(
                      onPressed: () {
                        if (_answerSelected) {
                          // Only proceed if an answer is selected
                          if (_currentQuestionIndex == _questions.length - 1) {
                            _submitAnswer();
                          } else {
                            _nextQuestion();
                          }
                        }
                      },
                      shape: GFButtonShape.pills,
                      color: const Color(0xFF06D6A0),
                      textStyle: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      text: _currentQuestionIndex == _questions.length - 1
                          ? 'Hoàn thành'
                          : 'Tiếp theo',
                      type: GFButtonType.solid,
                      size: GFSize.LARGE),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
