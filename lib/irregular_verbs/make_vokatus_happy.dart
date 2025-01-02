import 'package:flutter/material.dart';

class MakeVokatusHappy extends StatelessWidget {
  const MakeVokatusHappy({super.key, required this.onHappy});

  final VoidCallback onHappy;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onHappy, child: const Text('Make Vokatus Happy'));
  }
}
