import 'package:flutter/material.dart';
import 'package:vokatus/irregular_verbs/irregular_word_page.dart';

void main() {
  runApp(const VokatusApp());
}

class VokatusApp extends StatelessWidget {
  const VokatusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vokatus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          const VokatusHomePage(title: 'Vokatus - The Vocabular Learning Bear'),
    );
  }
}

class VokatusHomePage extends StatelessWidget {
  const VokatusHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: IrregularWordPage());
  }
}
