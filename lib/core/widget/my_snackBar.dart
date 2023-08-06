import 'package:flutter/material.dart';

void mySnackBar(BuildContext context, {required String message, Color? color,int? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(

      backgroundColor: color,
      content: SizedBox(
          height: 70,
          child: Center(
              child: Text(
            message,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ))),
      duration:  Duration(seconds:duration?? 5),
      // Width of the SnackBar.

      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}
