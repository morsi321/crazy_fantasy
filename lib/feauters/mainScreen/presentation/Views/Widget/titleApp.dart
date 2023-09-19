import 'package:flutter/material.dart';

class TitleApp extends StatelessWidget {
  const TitleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Crazy Fantasy",
      style: TextStyle(
          color: Colors.orange, fontSize: 30, fontWeight: FontWeight.bold),);
  }
}
