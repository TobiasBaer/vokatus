import 'package:bloc/bloc.dart';
import 'events.dart';
import 'states.dart';
import 'package:vokatus/app_settings/settings.dart' as app_settings;
import 'package:vokatus/buckets/buckets.dart';
import 'package:vokatus/vocabulary/irregular_verbs.dart';

class VocabularyQueryBusinessLogic
    extends Bloc<VocTrainerEvents, ProgressState> {
  final Buckets _buckets = Buckets(app_settings.numBuckets,
      List<int>.generate(irregularVerbs.length, (index) => index));

  // @TODO: Shuffle this
  VocabularyQueryBusinessLogic()
      : super(ProgressState(
            0,
            List<double>.generate(
                app_settings.numBuckets, (index) => index == 0 ? 1.0 : 0.0),
            0,
            false)) {
    on<RightAnswerEvent>((event, emit) {
      _buckets.processRightAnswer();
      _buckets.drawNext();
      var progress = _buckets.getBucketProgress();
      var currentBucket = _buckets.getCurrentBucket();
      var currentWordIndex = _buckets.getCurrentWordIndex();
      emit(ProgressState(
          currentBucket, progress, currentWordIndex, _buckets.allLearned()));
    });

    on<WrongAnswerEvent>((event, emit) {
      _buckets.processWrongAnswer();
      _buckets.drawNext();

      var progress = _buckets.getBucketProgress();
      var currentBucket = _buckets.getCurrentBucket();
      var currentWordIndex = _buckets.getCurrentWordIndex();

      emit(ProgressState(currentBucket, progress, currentWordIndex, false));
    });

    on<SkipAnswerEvent>((event, emit) {
      _buckets.processSkipAnswer();
      _buckets.drawNext();
      var progress = _buckets.getBucketProgress();
      var currentBucket = _buckets.getCurrentBucket();
      var currentWordIndex = _buckets.getCurrentWordIndex();

      emit(ProgressState(currentBucket, progress, currentWordIndex, false));
    });
  }
}
