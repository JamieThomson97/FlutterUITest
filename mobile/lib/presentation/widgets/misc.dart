import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Misc {
  static Text getBackgroundedText(
    String text, {
    double fontSize = 12,
    Color color = Colors.black,
  }) {
    return Text(
      " $text ",
      style: TextStyle(
          backgroundColor: Colors.white.withOpacity(0.9),
          fontSize: fontSize,
          color: color,
          fontStyle: FontStyle.italic),
    );
  }
}
