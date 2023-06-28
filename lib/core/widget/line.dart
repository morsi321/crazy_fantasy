import 'package:flutter/material.dart';

import '../utils/color_constant.dart';

class Line extends StatelessWidget {
  const Line({Key? key, this.paddingHeight}) : super(key: key);
  final double? paddingHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: paddingHeight ?? 20,
      ),
      color: ColorConstant.gray1,
      height: 1.5,
      width: double.infinity,
    );
  }
}
