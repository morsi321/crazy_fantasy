import 'package:flutter/material.dart';

void dialogFreeze(BuildContext context) {
  showDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const SizedBox();
      });
}
