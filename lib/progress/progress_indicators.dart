import 'package:flutter/material.dart';
import 'package:vokatus/app_settings/settings.dart' as app_settings;

class ProgressIndicators extends StatelessWidget {
  const ProgressIndicators(
      {super.key, required this.currentBucket, required this.bucketProgress});

  final int currentBucket;
  final List<double> bucketProgress;

  @override
  Widget build(BuildContext context) {
    print("build");
    assert(currentBucket < app_settings.numBuckets);
    assert(bucketProgress.length == app_settings.numBuckets);

    return Column(children: [
      for (int i = 0; i < app_settings.numBuckets; i++)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LinearProgressIndicator(
            value: bucketProgress[i],
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
          ),
        ),
    ]);
  }
}
