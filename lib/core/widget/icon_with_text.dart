import 'package:flutter/material.dart';


class IconWithText extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final double? size;

  const IconWithText(
      {super.key,
      required this.label,
      required this.icon,
      this.color,
      this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: size ?? 25,
          color: color ?? Colors.white,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          label,
          style: TextStyle(fontFamily: "Janna",color: color ?? Colors.white),
        ),
      ],
    );
  }
}
