import 'package:anime_and_comic_entertainment/model/challegens.dart';
import 'package:anime_and_comic_entertainment/services/challenges_api.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';

class ChallengeTest extends StatefulWidget {
  const ChallengeTest({Key? key}) : super(key: key);

  @override
  State<ChallengeTest> createState() => _ChallengeTestState();
}

class _ChallengeTestState extends State<ChallengeTest> {
  List<ChallengeQuestion> _questions = []; // Store fetched questions

  Future<List<ChallengeQuestion>> getChallengesQuestion() async {
    var result = await ChallegensApi.getChallengesQuestion(context);
    return result;
  }

  @override
  void initState() {
    super.initState();

    getChallengesQuestion().then((value) => value.forEach((element) {
          setState(() {
            _questions.add(ChallengeQuestion(
              id: element.id,
              questionName: element.questionName,
              answers: element.answers,
              correctAnswerID: element.correctAnswerID,
              mediaUrl: element.mediaUrl,
            ));
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: GFAppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF141414),
        title: const Column(
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
                  "1/10", // You can update this dynamically based on the number of questions fetched
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
          // Display questions dynamically
          for (var question in _questions)
            Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      question.mediaUrl,
                      height: 200,
                      width: 200,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var answer in question.answers)
                      AnswerOption(
                          text: answer.content,
                          color: Colors.red), // Display answers dynamically
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
                    onPressed: () {},
                    child: const Text('Trở lại'),
                  ),
                ),
                const SizedBox(
                    width: 8), // Adjust spacing between buttons if needed
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Tiếp theo'),
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

class AnswerOption extends StatelessWidget {
  final String? text;
  final Color color;

  const AnswerOption({Key? key, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
