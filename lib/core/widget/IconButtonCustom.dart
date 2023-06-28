import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom(
      {Key? key,
      required this.icon,
      this.borderRadius,
      required this.onTap,
      this.width,
      this.color,
      this.iconColor,
      this.height, this.iconSize})
      : super(key: key);
  final IconData icon;
  final BorderRadius? borderRadius;
  final void Function() onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Color? iconColor;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 100,
        height: height ?? 50,
        decoration: BoxDecoration(
          color: color ?? Colors.white70,
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          //  border: Border.all(width: 2,color: Colors.grey),
        ),
        child: Center(
          child: Icon(icon,size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}
