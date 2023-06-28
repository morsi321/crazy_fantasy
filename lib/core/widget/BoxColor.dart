import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:flutter/material.dart';

class BoxColor extends StatelessWidget {
  const BoxColor(
      {Key? key, required this.child, this.color, this.width, this.height, this.borderRadius, })
      : super(key: key);
  final Widget child;
  final Color? color;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.width * .44,
      height: height ?? context.height * .07,
      decoration: BoxDecoration(
        color: color ?? Colors.white.withOpacity(.3),
        borderRadius:borderRadius?? BorderRadius.circular(8),
      ),
      child: Center(child: child),
    );
  }
}
