import 'package:flutter/material.dart';

class Congratulations extends StatefulWidget {
  const Congratulations({super.key, required this.time});

  final String time;

  @override
  State<Congratulations> createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('make_vokatus_happy');
        },
        child: Text('Congratulations! ${widget.time}'));
  }
}
