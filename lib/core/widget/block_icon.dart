import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:flutter/material.dart';

import '../utils/color_constant.dart';


class IconBlock extends StatelessWidget {
  const IconBlock(
      {Key? key, required this.onTap, required this.icon, this.text})
      : super(key: key);
  final void Function() onTap;
  final IconData icon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: context.height * .22,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 100,
              color: ColorConstant.gray1,
            ),
            Text(
              text ?? "",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.gray1),
            )
          ],
        ),
      ),
    );
  }
}
