import 'package:flutter/material.dart';
import 'package:vokatus/app_settings/settings.dart' as app_settings;
import 'package:vokatus/progress/progress_indicators.dart';

class IrregularWordPage extends StatelessWidget {
  const IrregularWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: <Widget>[
          Text('Irregular Words'),
          ProgressIndicators(),
        ],
      ),
    );
  }
}
