import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  final String? answer;
  final bool? isCorrect;
  const ResultItem({
    super.key,
    this.answer,
    this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isCorrect!
                  ? const Color(0xff06d6a0)
                  : const Color(0xffef476f),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    answer!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 20,
                  child: Icon(
                    isCorrect! ? Icons.check : Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
