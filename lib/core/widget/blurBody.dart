import 'package:blur/blur.dart';
import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';



class BlurBody extends StatelessWidget {
  const BlurBody(
      {Key? key,
      required this.child,
      this.height,
      this.width,
      this.blur,
      this.borderRadius,
      this.frostColor,
      this.backgroundImage})
      : super(key: key);
  final Widget child;
  final double? height;
  final double? width;
  final double? blur;
  final String? backgroundImage;
  final Color? frostColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: borderRadius ??
              const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
          child: Image.asset(
            backgroundImage ?? "assets/images/sinai.jpeg",
            height: height ?? context.height * .63,
            width: width ?? double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: height ?? context.height * .63,
          width: width ?? context.width,
          child: child.frosted(
            frostColor: frostColor ?? Colors.black,
            blur: blur ?? 40,
            borderRadius: borderRadius ??
                const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
          ),
        ),
      ],
    );
  }
}
