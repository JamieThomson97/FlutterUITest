import 'dart:math';
import 'dart:core';

import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.light,
  primaryColor: Colors.lightBlue[800],
  accentColor: Colors.cyan[600],

  // Define the default font family.

  // Define the default TextTheme. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline4: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
    headline5: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
    ),
    headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(
      fontSize: 13.0,
      fontFamily: 'Hind',
    ),
  ),
);

class PresentationUtils {
  static Color backgroundGrey = Colors.grey[200]!;

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

extension ListExtensions<T> on List<T> {
  T getRandom() => this[Random().nextInt(this.length)];
}

class CustomBoxShadow extends BoxShadow {
  final BlurStyle blurStyle;

  const CustomBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
    double spreadRadius = 0,
  }) : super(
          color: color,
          offset: offset,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        );

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(this.blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows) result.maskFilter = null;
      return true;
    }());
    return result;
  }
}
