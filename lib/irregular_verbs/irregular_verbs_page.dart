import 'package:flutter/material.dart';
import 'package:vokatus/business_logic/logic.dart';
import 'package:vokatus/irregular_verbs/congratulations.dart';
import 'package:vokatus/irregular_verbs/irregular_vocabular_query.dart';
import 'package:vokatus/irregular_verbs/make_vokatus_happy.dart';
import 'package:easy_count_timer/easy_count_timer.dart';

class IrregularVerbsPage extends StatefulWidget {
  const IrregularVerbsPage({super.key});

  @override
  State<IrregularVerbsPage> createState() => _IrregularVerbsPageState();
}

class _IrregularVerbsPageState extends State<IrregularVerbsPage> {
  late VocabularyQueryBusinessLogic _businessLogic;
  var controller = CountTimerController();

  @override
  void initState() {
    _businessLogic = VocabularyQueryBusinessLogic();
    super.initState();
  }

  @override
  void dispose() {
    _businessLogic.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
        initialRoute: 'make_vokatus_happy',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case 'make_vokatus_happy':
              builder = (BuildContext context) => MakeVokatusHappy(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('irregular_vocabulary_query');
                      controller.restart();
                    },
                  );
              break;
            case 'irregular_vocabulary_query':
              builder = (BuildContext context) => IrregularVocabularQuery(
                  businessLogic: _businessLogic, timerController: controller);
              break;
            case 'congratulations':
              builder = (BuildContext context) =>
                  Congratulations(time: controller.duration.toString());

              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute<void>(builder: builder, settings: settings);
        });
  }
}
