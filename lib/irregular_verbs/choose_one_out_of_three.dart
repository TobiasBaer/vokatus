import 'package:flutter/material.dart';
import 'package:vokatus/vocabulary/irregular_verbs.dart';

class ChooseOneOutOfThree extends StatefulWidget {
  ChooseOneOutOfThree(
      {super.key,
      required type,
      required wordIndex,
      this.onRight,
      this.onWrong,
      this.onSkip}) {
    assert(wordIndex >= 0);

    var fakeWordsIndices = falseWordsIndices(wordIndex);

    if (type == "infinitive") {
      correctWord = irregularVerbs[wordIndex].infinitive;
      choices.add(irregularVerbs[fakeWordsIndices[0]].infinitive);
      choices.add(irregularVerbs[fakeWordsIndices[1]].infinitive);
    } else if (type == "simplePast") {
      correctWord = irregularVerbs[wordIndex].simplePast;
      choices.add(irregularVerbs[fakeWordsIndices[0]].simplePast);
      choices.add(irregularVerbs[fakeWordsIndices[1]].simplePast);
    } else if (type == "pastParticiple") {
      correctWord = irregularVerbs[wordIndex].pastParticiple;
      choices.add(irregularVerbs[fakeWordsIndices[0]].pastParticiple);
      choices.add(irregularVerbs[fakeWordsIndices[1]].pastParticiple);
    } else {
      throw Exception("Invalid type: $type");
    }
    choices.add(correctWord);
    choices.shuffle();
  }

  List<int> falseWordsIndices(int wordIndex) {
    final List<int> indices =
        List<int>.generate(irregularVerbs.length, (index) => index);
    indices.remove(wordIndex);
    indices.shuffle();
    return indices.sublist(0, 2);
  }

  final VoidCallback? onRight;
  final VoidCallback? onWrong;
  final VoidCallback? onSkip;

  late final String correctWord;
  late final List<String> choices = [];

  @override
  State<ChooseOneOutOfThree> createState() => _ChooseOneOutOfThree();
}

class _ChooseOneOutOfThree extends State<ChooseOneOutOfThree> {
  List<bool> isSelected = [false, false, false];
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
        isSelected: isSelected,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
            }
          });

          isCorrect = widget.choices[index] == widget.correctWord;

          if (isCorrect) {
            widget.onRight?.call();
            print("Choose on out of tree - Correct!");
          } else {
            widget.onWrong?.call();
            print("Choose on out of tree - Wrong!");
          }
        },
        direction: Axis.vertical,
        borderRadius: const BorderRadius.all(Radius.circular(0)),
        selectedBorderColor: Colors.red[700],
        selectedColor: Colors.white,
        fillColor: Colors.red[200],
        color: Colors.red[400],
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 80.0,
        ),
        children: [for (var choice in widget.choices) Text(choice)]);
  }
}
