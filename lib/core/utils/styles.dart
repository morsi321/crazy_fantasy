import 'package:flutter/material.dart';

import 'color_constant.dart';

abstract class Styles {
  static const subTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
  );

  static const heading = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
  );

  static const lightFont = TextStyle(
    fontSize: 13,
    color: Colors.grey,
    fontWeight: FontWeight.w700,
  );
  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static const textStyle30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.2,
  );
  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const textStyle16 = TextStyle(
    fontSize: 16,
    color: ColorConstant.kPrimayColor,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
}

const TextStyle textStyle = TextStyle();
