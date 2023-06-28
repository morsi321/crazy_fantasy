import 'package:flutter/material.dart';

import '../utils/color_constant.dart';

class BorderWithLabel extends StatelessWidget {
  const BorderWithLabel(
      {Key? key,
      required this.label,
      required this.child,
      this.color,
      this.height})
      : super(key: key);
  final String label;
  final Widget child;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
                color: color ?? Colors.grey,
                fontSize: 25,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide:
                    BorderSide(color: color ?? ColorConstant.gray1, width: 2)),
            contentPadding: const EdgeInsets.all(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: child,
          )),
    );
  }
}
