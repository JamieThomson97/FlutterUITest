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
    bodyText2: TextStyle(fontSize: 13.0, fontFamily: 'Hind'),
  ),
);
