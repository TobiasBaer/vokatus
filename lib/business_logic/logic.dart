import 'package:bloc/bloc.dart';
import 'events.dart';
import 'states.dart';
import 'package:vokatus/app_settings/settings.dart' as app_settings;

class VocabularyQueryBusinessLogic
    extends Bloc<VocTrainerEvents, ProgressState> {
  VocabularyQueryBusinessLogic()
      : super(ProgressState(
            0,
            List<double>.generate(
                app_settings.numBuckets, (index) => index == 0 ? 1.0 : 0.0))) {
    on<RightAnswerEvent>((event, emit) {
      print("BLOC - Right Answer Event");
      emit(ProgressState(0, [0.1, 0.2, 0.0, 0.0]));
    });

    on<WrongAnswerEvent>((event, emit) {
      print("BLOC - Wrong Answer Event");
      emit(ProgressState(0, [0.7, 0.2, 0.3, 0.4]));
    });

    on<SkipVocableEvent>((event, emit) {
      print("BLOC - Skip Event");
      emit(ProgressState(0, [0.9, 0.9, 0.9, 0.4]));
    });
  }
}
