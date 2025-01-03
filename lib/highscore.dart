import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Highscore App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HighscorePage(),
    );
  }
}

class HighscorePage extends StatefulWidget {
  @override
  _HighscorePageState createState() => _HighscorePageState();
}

class _HighscorePageState extends State<HighscorePage> {
  Database? database;
  List<Map<String, dynamic>> highscores = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'highscore_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE highscores(id INTEGER PRIMARY KEY, name TEXT, score INTEGER)",
        );
      },
      version: 1,
    );
    await _fetchHighscores();
  }

  Future<void> _fetchHighscores() async {
    final List<Map<String, dynamic>> maps = await database!.query('highscores');
    setState(() {
      highscores = maps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Highscores'),
      ),
      body: ListView.builder(
        itemCount: highscores.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(highscores[index]['name']),
            subtitle: Text('Score: ${highscores[index]['score']}'),
          );
        },
      ),
    );
  }
}
