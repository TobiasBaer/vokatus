import 'package:flutter/material.dart';

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

class VokatusHomePage extends StatefulWidget {
  const VokatusHomePage({super.key, required this.title});

  final String title;

  @override
  State<VokatusHomePage> createState() => _VokatusHomePageState();
}

class _VokatusHomePageState extends State<VokatusHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
