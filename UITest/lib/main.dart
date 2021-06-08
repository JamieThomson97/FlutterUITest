import 'package:vibration/screens/artist_page.dart';
import 'package:vibration/screens/home_page.dart';
import 'package:vibration/screens/search_page.dart';
import 'package:vibration/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: theme,
    );
  }
}
