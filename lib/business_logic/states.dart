// @todo: divide into separate states
class ProgressState {
  final int currentBucket;
  final List<double> bucketProgress;
  final int currentWordIndex;
  final bool allLearned;

  ProgressState(this.currentBucket, this.bucketProgress, this.currentWordIndex,
      this.allLearned);
}
