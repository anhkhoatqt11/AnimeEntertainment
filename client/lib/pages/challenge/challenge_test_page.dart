import 'package:anime_and_comic_entertainment/components/challenge/AnswerOption.dart';
import 'package:anime_and_comic_entertainment/model/challenges.dart';
import 'package:anime_and_comic_entertainment/services/challenges_api.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

class ChallengeTest extends StatefulWidget {
  const ChallengeTest({Key? key}) : super(key: key);

  @override
  State<ChallengeTest> createState() => _ChallengeTestState();
}

class _ChallengeTestState extends State<ChallengeTest> {
  late List<ChallengeQuestion> _questions;
  int _currentQuestionIndex = 0;
  Map<int, int?> _userAnswers =
      {}; // Map to store user answers, key: question index, value: selected answer index

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
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
      }
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
    });
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

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: GFAppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF141414),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
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
                Text(
                  "Câu hỏi tuần này",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "${_currentQuestionIndex + 1}/${_questions.length}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                question.mediaUrl,
                height: 200,
                width: 350,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: Text(
              question.questionName,
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < question.answers.length; i++)
                GestureDetector(
                  onTap: () => _selectAnswer(i),
                  child: AnswerOption(
                    text: question.answers[i].content,
                    color: _userAnswers[_currentQuestionIndex] == i
                        ? Colors.red
                        : Colors.blue, // Change color based on selection
                  ),
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
                      _nextQuestion();
                      // Save or submit answers when all questions are answered
                      if (_currentQuestionIndex == _questions.length - 1) {
                        // Call a function to save or submit the answers
                      }
                    },
                    child: _currentQuestionIndex == _questions.length - 1
                        ? const Text('Nộp bài')
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
