import 'package:flutter/material.dart';

void showBottomSheetCustom(BuildContext context, Widget child) {
  showModalBottomSheet(
    barrierColor: Colors.black.withOpacity(.3),

    backgroundColor:   const Color.fromRGBO(28, 22, 54, .9),

  context: context,
    builder: (BuildContext context) {
      return child;
    },
  );
}
