class ProgressState {
  final int currentBucket;
  final List<double> bucketProgress;
  final int currentWordIndex;

  ProgressState(this.currentBucket, this.bucketProgress, this.currentWordIndex);
}
