import 'package:UITest/screens/artist_page.dart';
import 'package:UITest/screens/home_page.dart';
import 'package:UITest/screens/search_page.dart';
import 'package:UITest/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ArtistPage(),
      theme: theme,
    );
  }
}
