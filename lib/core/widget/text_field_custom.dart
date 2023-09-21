import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:flutter/material.dart';

class TextFromCustom extends StatelessWidget {
  const TextFromCustom(
      {Key? key,
      this.height,
      this.width,
      required this.label,
      this.controller,
      this.disableBorder = false,
      this.style,
      this.prefixIcon,
      this.fillColor,
      this.radius,
      this.validator,
      this.enable,
      this.suffixIcon,
      this.obscureText,
      this.onChanged,
      this.hintText, this.onFieldSubmitted})
      : super(key: key);
  final double? height;
  final double? width;
  final String label;
  final TextEditingController? controller;
  final bool disableBorder;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Color? fillColor;
  final double? radius;
  final bool? enable;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
 final void Function(String)? onFieldSubmitted;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width ?? context.width * 0.40,
        child: TextFormField(
            // enabled: enable??true,
            onChanged: onChanged,
            obscureText: obscureText ?? false,
            controller: controller,
            style: style,
            readOnly: enable ?? false,
            validator: validator,
            onFieldSubmitted:onFieldSubmitted,

            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: style,
              fillColor: fillColor,
              filled: fillColor != null ? true : false,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              labelText: label,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 5)),
                  borderSide: BorderSide(
                      color: disableBorder ? Colors.transparent : Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 5)),
                  borderSide: BorderSide(
                      color: disableBorder ? Colors.transparent : Colors.grey)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 1)),
                borderSide: BorderSide(
                    color: disableBorder ? Colors.transparent : Colors.grey),
              ),
            )));
  }
}
