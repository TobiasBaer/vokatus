import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vokatus/business_logic/events.dart';
import 'package:vokatus/business_logic/logic.dart';
import 'package:vokatus/business_logic/states.dart';
import 'package:vokatus/irregular_verbs/irregular_voc_trainer_query.dart';
import 'package:vokatus/progress/progress_indicators.dart';

class IrregularVocabularQuery extends StatelessWidget {
  const IrregularVocabularQuery({
    super.key,
    required VocabularyQueryBusinessLogic businessLogic,
  }) : _businessLogic = businessLogic;

  final VocabularyQueryBusinessLogic _businessLogic;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => VocabularyQueryBusinessLogic(),
        child: Center(
          child: Column(
            children: <Widget>[
              BlocBuilder<VocabularyQueryBusinessLogic, ProgressState>(
                  bloc: _businessLogic,
                  builder: (context, state) => IrregularVocTrainerQuery(
                      wordIndex: state.currentWordIndex,
                      onRight: () {
                        _businessLogic.add(RightAnswerEvent());
                        if (state.allLearned == true) {
                          Navigator.of(context)
                              .pushReplacementNamed('congratulations');
                        }
                      },
                      onWrong: () => _businessLogic.add(WrongAnswerEvent()),
                      onSkip: () => _businessLogic.add(SkipAnswerEvent()))),
              BlocBuilder<VocabularyQueryBusinessLogic, ProgressState>(
                  bloc: _businessLogic,
                  builder: (context, state) => ProgressIndicators(
                      currentBucket: state.currentBucket,
                      bucketProgress: state.bucketProgress)),
            ],
          ),
        ));
  }
}
