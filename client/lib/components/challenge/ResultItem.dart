import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  final String? answer;
  final bool? isCorrect;
  const ResultItem({super.key, this.answer, this.isCorrect, });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isCorrect! ? const Color(0xff06d6a0) : const Color(0xffef476f),
              borderRadius: BorderRadius.circular(6.0),
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(answer!),
              Icon(isCorrect! ? Icons.check : Icons.close, color: isCorrect! ? Colors.green : Colors.red, size: 24,),
            ],
          )),
      ),
    );  }
}
