import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BackgroundText extends StatelessWidget {
  const BackgroundText(this.text, {Key? key, this.fontSize = 12}) : super(key: key);

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(" $text ",
        style: TextStyle(
          backgroundColor: Colors.white.withOpacity(0.9),
          fontSize: fontSize,
          color: Colors.black,
        ));
  }
}
