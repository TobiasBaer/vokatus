import 'package:flutter/material.dart';
import 'package:vokatus/app_settings/settings.dart' as app_settings;

class ProgressIndicators extends StatelessWidget {
  const ProgressIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (int i = 0; i < app_settings.numBuckets; i++)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LinearProgressIndicator(
            value: 0.1,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          ),
        ),
    ]);
  }
}
