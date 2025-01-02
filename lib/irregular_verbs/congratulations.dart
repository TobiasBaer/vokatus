import 'package:flutter/material.dart';

class Congratulations extends StatelessWidget {
  const Congratulations({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Congratulations!'));
  }
}
