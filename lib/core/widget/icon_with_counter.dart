import 'package:flutter/material.dart';

class IconWithCounter extends StatelessWidget {
  final IconData icon;
  final int counter;

const  IconWithCounter({super.key, required this.icon, required this.counter});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(icon,size: 50,), // The Icon widget
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              counter.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ), // The counter widget
      ],
    );
  }
}