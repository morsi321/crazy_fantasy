import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage(
                'assets/images/logo.png',
              ),
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.05),
                BlendMode.modulate,
              ))),
      child: child,
    );
  }
}
