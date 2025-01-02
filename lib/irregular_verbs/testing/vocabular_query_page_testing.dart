import 'package:flutter/material.dart';
import 'package:vokatus/vocabulary/irregular_verbs.dart';

class VocabularQueryPageTesting extends StatelessWidget {
  const VocabularQueryPageTesting(
      {super.key,
      required this.wordIndex,
      required this.onRight,
      required this.onWrong,
      required this.onSkip});

  final int wordIndex;
  final VoidCallback onRight;
  final VoidCallback onWrong;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(irregularVerbs[wordIndex].german),
      Row(children: [
        ElevatedButton(
          onPressed: onRight,
          child: Text("Right"),
        ),
        ElevatedButton(
          onPressed: onWrong,
          child: Text("Wrong"),
        ),
        ElevatedButton(
          onPressed: onSkip,
          child: Text("Skip"),
        )
      ]),
    ]);
  }
}
