typedef Bucket = List<int>;

class Buckets {
  Buckets(this._numBuckets, List<int> vocableIndices) {
    assert(_numBuckets > 1);
    assert(vocableIndices.isNotEmpty);
    buckets = List<Bucket>.generate(_numBuckets,
        (index) => index == 0 ? List<int>.from(vocableIndices) : []);
    _initialVocableIndicesLength = vocableIndices.length;
  }

  final int _numBuckets;
  late List<Bucket> buckets;
  int currentBucket = 0;
  late int _initialVocableIndicesLength;

  void debug() {
    // print("Current bucket: $currentBucket");
    // print("Buckets:");
    // for (var i = 0; i < _numBuckets; i++) {
    //   print("Bucket $i: ${buckets[i]}");
    // }
  }

  int getCurrentWordIndex() {
    return buckets[currentBucket].first;
  }

  void processRightAnswer() {
    if (allLearned()) {
      return;
    }

    var currentWordIndex = getCurrentWordIndex();
    buckets[currentBucket].remove(currentWordIndex);
    if (currentBucket < _numBuckets - 1) {
      buckets[currentBucket + 1].add(currentWordIndex);
    }

    _selectBucket();
    debug();
  }

  void processWrongAnswer() {
    if (currentBucket == 0) {
      return;
    }
    if (allLearned()) {
      return;
    }

    var currentWordIndex = getCurrentWordIndex();
    buckets[currentBucket].remove(currentWordIndex);
    buckets[0].add(currentWordIndex);

    _selectBucket();
    debug();
  }

  void processSkipAnswer() {
    if (allLearned()) {
      return;
    }
    // do nothing by now
    debug();
  }

  void _selectBucket() {
    if (buckets[currentBucket].isEmpty) {
      for (var i = 0; i < _numBuckets; i++) {
        if (buckets[i].isNotEmpty) {
          currentBucket = i;
          break;
        }
      }
    }
    debug();
  }

  int getCurrentBucket() {
    return currentBucket;
  }

  List<double> getBucketProgress() {
    return List<double>.generate(_numBuckets, (index) {
      return buckets[index].length / _initialVocableIndicesLength;
    });
  }

  bool allLearned() {
    return buckets[_numBuckets - 1].length == _initialVocableIndicesLength;
  }

  void drawNext() {
    buckets[currentBucket].shuffle();
  }
}
