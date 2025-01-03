import 'package:flutter/material.dart';

class MakeVokatusHappy extends StatelessWidget {
  const MakeVokatusHappy({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
                image: AssetImage('assets/larissa_baer.png'),
                height: size.height * 0.5),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Do you promise to make Vokatus happy?"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: onPressed, child: const Text('Yes, I promise!')),
          ),
        ],
      ),
    );
  }
}
