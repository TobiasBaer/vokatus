import 'package:flutter_test/flutter_test.dart';
import 'package:vokatus/buckets/buckets.dart';

void main() {
  group('Buckets', () {
    const numBuckets = 3;
    const indicies = [0, 1, 2, 3];

    test('initialize with a invalid number of buckets', () {
      expect(() => Buckets(0, indicies), throwsAssertionError);
      expect(() => Buckets(1, indicies), throwsAssertionError);
    });

    test('initialize with a invalid number of vocabularies', () {
      expect(() => Buckets(3, []), throwsAssertionError);
    });

    test(
        'initialize with the correct number of buckets and have all indicies in the first bucket. All others are empty',
        () {
      final buckets = Buckets(numBuckets, indicies);
      expect(buckets.buckets.length, numBuckets);
      for (var i = 0; i < buckets.buckets.length; i++) {
        var bucket = buckets.buckets[i];
        expect(i == 0 || bucket.isEmpty, true);
        expect(i != 0 || bucket.length == indicies.length, true);
        expect(buckets.getCurrentBucket(), 0);

        var progress = buckets.getBucketProgress();
        expect(progress.length, numBuckets);
        expect(progress[0], 1.0);
        for (var i = 1; i < progress.length; i++) {
          expect(progress[i], 0.0);
        }
      }
      expect(buckets.allLearned(), false);
    });

    test('process a correct answer from initial state', () {
      final buckets = Buckets(numBuckets, indicies);
      var currentWordIndex = buckets.getCurrentWordIndex();

      buckets.processRightAnswer();

      expect(buckets.getCurrentBucket(), 0);

      expect(buckets.buckets[0].length, indicies.length - 1);
      expect(buckets.buckets[0].contains(currentWordIndex), false);

      expect(buckets.buckets[1].length, 1);
      expect(buckets.buckets[1].contains(currentWordIndex), true);

      for (var i = 2; i < buckets.buckets.length; i++) {
        expect(buckets.buckets[i].isEmpty, true);
        expect(buckets.buckets[i].contains(currentWordIndex), false);
      }
      expect(buckets.allLearned(), false);
    });

    test('process a wrong answer from initial state', () {
      final buckets = Buckets(numBuckets, indicies);
      var currentWordIndex = buckets.getCurrentWordIndex();

      buckets.processWrongAnswer();
      expect(buckets.getCurrentBucket(), 0);

      expect(buckets.buckets[0].length, indicies.length);
      expect(buckets.buckets[0].contains(currentWordIndex), true);

      for (var i = 1; i < buckets.buckets.length; i++) {
        expect(buckets.buckets[i].isEmpty, true);
        expect(buckets.buckets[i].contains(currentWordIndex), false);
      }
      expect(buckets.allLearned(), false);
    });

    test('process a correct answer with bucket change', () {
      final buckets = Buckets(numBuckets, indicies);

      for (var i = 1; i < numBuckets; ++i) {
        for (var i = 0; i < indicies.length; ++i) {
          buckets.processRightAnswer();
        }
        expect(buckets.buckets[i - 1].isEmpty, true);
        expect(buckets.getCurrentBucket(), i);
        expect(buckets.buckets[i].length, indicies.length);

        var progress = buckets.getBucketProgress();
        expect(progress[i - 1], 0.0);
        expect(progress[i], 1.0);
      }

      expect(buckets.allLearned(), true);
    });
  });
}
