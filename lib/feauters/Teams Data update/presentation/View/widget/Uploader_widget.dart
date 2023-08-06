
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UploaderWidget extends StatelessWidget {
  const UploaderWidget({super.key, required this.current, required this.end});

  final double current;
  final double end;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 45,
                thumbShape: SliderComponentShape.noThumb,
                disabledActiveTrackColor: Colors.red[700],
                disabledInactiveTrackColor: Colors.red[100],
              ),
              child: Slider(
                value: current,
                onChanged: null,
                max: end,

              )),
          Text("${(current / end * 100).toStringAsFixed(0)} %",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
