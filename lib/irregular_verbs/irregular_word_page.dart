import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vokatus/business_logic/events.dart';
import 'package:vokatus/business_logic/logic.dart';
import 'package:vokatus/business_logic/states.dart';
import 'package:vokatus/progress/progress_indicators.dart';

class VocabularQueryPage extends StatelessWidget {
  const VocabularQueryPage(
      {super.key,
      required this.word,
      required this.onRight,
      required this.onWrong,
      required this.onSkip});

  final String word;
  final VoidCallback onRight;
  final VoidCallback onWrong;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(word),
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

class IrregularWordPage extends StatefulWidget {
  const IrregularWordPage({super.key});

  @override
  State<IrregularWordPage> createState() => _IrregularWordPageState();
}

class _IrregularWordPageState extends State<IrregularWordPage> {
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
    return BlocProvider(
        create: (_) => VocabularyQueryBusinessLogic(),
        child: Center(
          child: Column(
            children: <Widget>[
              VocabularQueryPage(
                  word: "kaufen",
                  onRight: () => _businessLogic.add(RightAnswerEvent()),
                  onWrong: () => _businessLogic.add(WrongAnswerEvent()),
                  onSkip: () => _businessLogic.add(SkipAnswerEvent())),
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
