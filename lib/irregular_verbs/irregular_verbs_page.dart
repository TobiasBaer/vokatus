import 'package:flutter/material.dart';
import 'package:vokatus/business_logic/logic.dart';
import 'package:vokatus/irregular_verbs/congratulations.dart';
import 'package:vokatus/irregular_verbs/irregular_vocabular_query.dart';
import 'package:vokatus/irregular_verbs/make_vokatus_happy.dart';

class IrregularVerbsPage extends StatefulWidget {
  const IrregularVerbsPage({super.key});

  @override
  State<IrregularVerbsPage> createState() => _IrregularVerbsPageState();
}

class _IrregularVerbsPageState extends State<IrregularVerbsPage> {
  late VocabularyQueryBusinessLogic _businessLogic;

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
                    onHappy: () {
                      Navigator.of(context)
                          .pushReplacementNamed('irregular_vocabulary_query');
                    },
                  );
              break;
            case 'irregular_vocabulary_query':
              builder = (BuildContext context) =>
                  IrregularVocabularQuery(businessLogic: _businessLogic);
              break;
            case 'congratulations':
              builder = (BuildContext context) => const Congratulations();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute<void>(builder: builder, settings: settings);
        });
  }
}
