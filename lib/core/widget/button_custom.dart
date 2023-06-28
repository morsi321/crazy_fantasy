import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ButtonCustom extends StatelessWidget {
  const ButtonCustom(
      {Key? key,
      this.borderRadius,
      required this.onTap,
      this.width,
      this.color,
      required this.label,
      this.height,
      this.colorText,
      this.fontSize,
      this.icon})
      : super(key: key);
  final String label;
  final BorderRadius? borderRadius;
  final void Function() onTap;
  final double? width;
  final double? height;
  final Color? color;
  final Color? colorText;
  final double? fontSize;
  final IconData? icon;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: colorText,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 5,
            ),
            icon != null
                ? Icon(
                    icon,
                    color: colorText,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
