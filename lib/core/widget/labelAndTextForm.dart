import 'package:crazy_fantasy/core/widget/text_field_custom.dart';
import 'package:flutter/material.dart';

class LabelAndTextForm extends StatelessWidget {
  const LabelAndTextForm({
    Key? key,
    required this.label,
    this.width,
    this.controller,
    this.enable,
    this.suffixIcon,
  }) : super(key: key);
  final String label;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  final double? width;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontFamily: 'janna', fontSize: 18),
          ),
        ),
        const SizedBox(height: 5),
        TextFromCustom(
          obscureText: label == "Password" ? true : false,
          suffixIcon: suffixIcon,
          enable: enable,
          controller: controller,
          fillColor: Colors.white.withOpacity(.1),
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          height: 55,
          radius: 5,
          width: width ?? double.infinity,
          label: "",
          disableBorder: true,
        ),
      ],
    );
  }
}
