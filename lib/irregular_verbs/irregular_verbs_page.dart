import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vokatus/business_logic/events.dart';
import 'package:vokatus/business_logic/logic.dart';
import 'package:vokatus/business_logic/states.dart';
import 'package:vokatus/progress/progress_indicators.dart';
import 'package:vokatus/vocabulary/irregular_verbs.dart';
import 'package:vokatus/irregular_verbs/choose_one_out_of_three.dart';

class IrregularVocTrainerQuery extends StatefulWidget {
  const IrregularVocTrainerQuery(
      {super.key,
      required this.wordIndex,
      this.onRight,
      this.onWrong,
      this.onSkip});

  final int wordIndex;
  final VoidCallback? onRight;
  final VoidCallback? onWrong;
  final VoidCallback? onSkip;

  @override
  State<IrregularVocTrainerQuery> createState() =>
      _IrregularVocTrainerQueryState();
}

class _IrregularVocTrainerQueryState extends State<IrregularVocTrainerQuery> {
  bool infinitiveCorrect = false;
  bool simplePastCorrect = false;
  bool pastParticipleCorrect = false;

  bool infinitivePressed = false;
  bool simplePastPressed = false;
  bool pastParticiplePressed = false;

  void showOverlay(BuildContext context) {
    var correctWord = irregularVerbs[widget.wordIndex];

    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.3,
        left: MediaQuery.of(context).size.width * 0.2,
        child: Material(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.4,
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: Center(
              child: Column(
                children: [
                  Text(correctWord.german),
                  Text(
                    correctWord.infinitive,
                  ),
                  Text(
                    correctWord.simplePast,
                  ),
                  Text(
                    correctWord.pastParticiple,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Remove overlay entry after a delay
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  bool allPressed() {
    return infinitivePressed && simplePastPressed && pastParticiplePressed;
  }

  bool allCorrect() {
    return infinitiveCorrect && simplePastCorrect && pastParticipleCorrect;
  }

  void reportResult() {
    if (allPressed()) {
      if (allCorrect()) {
        widget.onRight!();
      } else {
        showOverlay(context);
        widget.onWrong!();
      }
    }
  }

  void onRightInfinitive() {
    infinitivePressed = true;
    infinitiveCorrect = true;
    reportResult();
  }

  void onRightSimplePast() {
    simplePastPressed = true;
    simplePastCorrect = true;
    reportResult();
  }

  void onRightPastParticiple() {
    pastParticiplePressed = true;
    pastParticipleCorrect = true;
    reportResult();
  }

  void onWrongSimplePast() {
    simplePastPressed = true;
    simplePastCorrect = false;
    reportResult();
  }

  void onWrongInfinitive() {
    infinitivePressed = true;
    infinitiveCorrect = false;
    reportResult();
  }

  void onWrongPastParticiple() {
    pastParticiplePressed = true;
    pastParticipleCorrect = false;
    reportResult();
  }

  void reset() {
    infinitivePressed = false;
    simplePastPressed = false;
    pastParticiplePressed = false;

    infinitiveCorrect = false;
    simplePastCorrect = false;
    pastParticipleCorrect = false;
  }

  @override
  void didUpdateWidget(covariant IrregularVocTrainerQuery oldWidget) {
    super.didUpdateWidget(oldWidget);
    reset();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(children: [
      Center(
          child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(irregularVerbs[widget.wordIndex].german),
        ),
      )),
      Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(30),
              child: ChooseOneOutOfThree(
                  type: "infinitive",
                  onRight: onRightInfinitive,
                  onWrong: onWrongInfinitive,
                  onSkip: widget.onSkip,
                  wordIndex: widget.wordIndex)),
          Padding(
              padding: const EdgeInsets.all(30),
              child: ChooseOneOutOfThree(
                  type: "simplePast",
                  onRight: onRightSimplePast,
                  onWrong: onWrongSimplePast,
                  onSkip: widget.onSkip,
                  wordIndex: widget.wordIndex)),
          Padding(
              padding: const EdgeInsets.all(30),
              child: ChooseOneOutOfThree(
                  type: "pastParticiple",
                  onRight: onRightPastParticiple,
                  onWrong: onWrongPastParticiple,
                  onSkip: widget.onSkip,
                  wordIndex: widget.wordIndex)),
        ],
      )
    ]);
  }
}

class IrregularVerbsPage extends StatefulWidget {
  const IrregularVerbsPage({super.key});

  @override
  State<IrregularVerbsPage> createState() => _IrregularVerbsPageState();
}

class _IrregularVerbsPageState extends State<IrregularVerbsPage> {
  late VocabularyQueryBusinessLogic _businessLogic;

  @override
  void initState() {
    _businessLogic = VocabularyQueryBusinessLogic();
    super.initState();
  }

  @override
  void dispose() {
    _businessLogic.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        initialRoute: 'make_vokatus_happy',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case 'make_vokatus_happy':
              builder = (BuildContext context) => const MakeVokatusHappy();
              break;
            case 'irregular_vocabulary_query':
              builder = (BuildContext context) =>
                  IrregularVocabularQuery(businessLogic: _businessLogic);
              break;
            case 'congratulations':
              builder = (BuildContext context) => const Congratulations();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute<void>(builder: builder, settings: settings);
        });
  }
}

class MakeVokatusHappy extends StatelessWidget {
  const MakeVokatusHappy({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .pushReplacementNamed('irregular_vocabulary_query');
        },
        child: const Text('Make Vokatus Happy'));
  }
}

class Congratulations extends StatelessWidget {
  const Congratulations({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Congratulations!'));
  }
}

class IrregularVocabularQuery extends StatelessWidget {
  const IrregularVocabularQuery({
    super.key,
    required VocabularyQueryBusinessLogic businessLogic,
  }) : _businessLogic = businessLogic;

  final VocabularyQueryBusinessLogic _businessLogic;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => VocabularyQueryBusinessLogic(),
        child: Center(
          child: Column(
            children: <Widget>[
              BlocBuilder<VocabularyQueryBusinessLogic, ProgressState>(
                  bloc: _businessLogic,
                  builder: (context, state) => IrregularVocTrainerQuery(
                      wordIndex: state.currentWordIndex,
                      onRight: () {
                        _businessLogic.add(RightAnswerEvent());
                        if (state.allLearned == true) {
                          Navigator.of(context)
                              .pushReplacementNamed('congratulations');
                        }
                      },
                      onWrong: () => _businessLogic.add(WrongAnswerEvent()),
                      onSkip: () => _businessLogic.add(SkipAnswerEvent()))),
              BlocBuilder<VocabularyQueryBusinessLogic, ProgressState>(
                  bloc: _businessLogic,
                  builder: (context, state) => ProgressIndicators(
                      currentBucket: state.currentBucket,
                      bucketProgress: state.bucketProgress)),
            ],
          ),
        ));
  }
}
