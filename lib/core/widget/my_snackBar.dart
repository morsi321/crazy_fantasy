import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:flutter/material.dart';

void mySnackBar(BuildContext context, {required String message, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.only(bottom: context.height * 0.6),

      backgroundColor: color,
      content: SizedBox(
          height: 70,
          child: Center(
              child: Text(
            message,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ))),
      duration: const Duration(seconds: 5),
      // Width of the SnackBar.

      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}
