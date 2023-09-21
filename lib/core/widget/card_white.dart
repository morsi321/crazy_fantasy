import 'package:flutter/material.dart';

import '../constance/colors.dart';


class CardWhite extends StatelessWidget {
  const CardWhite({super.key,  this.padding, required this.child, this.margin, this.border, this.color, this.width, this.height, this.borderRadius});

  final EdgeInsetsGeometry?  padding;
  final Widget child;
final  EdgeInsetsGeometry? margin;
final BoxBorder? border;
final Color? color;
final double ? width;
final double ? height;
final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding?? const EdgeInsets.all(8),
      margin:margin ,
      decoration:   BoxDecoration(
        color: color??AppColors.whiteLight,
        borderRadius: borderRadius?? BorderRadius.circular(5),
        border: border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
