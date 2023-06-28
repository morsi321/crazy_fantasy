import 'package:crazy_fantasy/core/extension/MediaQueryValues.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DroDownCustom extends StatelessWidget {
  const DroDownCustom(
      {Key? key,
      required this.onTap,
      required this.items,
      required this.labelDropDown,
      required this.selectedValue,
      this.width,
      this.colorBorder})
      : super(key: key);
  final Function(String?) onTap;
  final List<String> items;
  final String labelDropDown;
  final double? width;
  final String selectedValue;
  final Color? colorBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width ?? context.width * 0.45,
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelDropDown,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorBorder ?? Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
        child: ButtonTheme(


          materialTapTargetSize: MaterialTapTargetSize.padded,
          child: DropdownButton<String>(
            dropdownColor: const Color.fromRGBO(28, 22, 54, 10),
            hint: const Text("Select item"),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            isExpanded: true,
            value: selectedValue,
            elevation: 16,
            underline: DropdownButtonHideUnderline(
              child: Container(),
            ),
            onChanged: (String? newValue) {
              onTap(newValue);
            },
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
