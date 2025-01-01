import 'package:flutter/material.dart';
import 'package:vokatus/progress/progress_indicators.dart';

class VocabularQueryPage extends StatelessWidget {
  const VocabularQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('word'),
      Row(children: [
        ElevatedButton(
          child: Text("Right"),
          onPressed: () {},
        ),
        ElevatedButton(
          child: Text("Wrong"),
          onPressed: () {},
        ),
        ElevatedButton(
          child: Text("Skip"),
          onPressed: () {},
        )
      ]),
    ]);
  }
}

class IrregularWordPage extends StatelessWidget {
  const IrregularWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: <Widget>[
          VocabularQueryPage(),
          ProgressIndicators(),
        ],
      ),
    );
  }
}
