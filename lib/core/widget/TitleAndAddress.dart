import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/color_constant.dart';


class TradeTypeAndTitleAndAddress extends StatelessWidget {
  const TradeTypeAndTitleAndAddress(
      {Key? key,
      required this.tradeType,
      required this.address,
      required this.title})
      : super(key: key);
  final String tradeType;
  final String address;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tradeType,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorConstant.gold,
            ),
          ),
          Platform.isIOS
              ? const SizedBox(
                  height: 5,
                )
              : SizedBox(),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                // fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis),
          ),
          Platform.isIOS
              ? const SizedBox(
                  height: 5,
                )
              : const SizedBox(),
          Text(
            address,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontSize: 15, color: ColorConstant.gray1),
          ),
        ],
      ),
    );
  }
}
