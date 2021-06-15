import 'package:firebase_core/firebase_core.dart';
import 'package:vibration/presentation/pages/artist_page.dart';
import 'package:vibration/presentation/pages/home_page.dart';
import 'package:vibration/presentation/pages/now_playing_page.dart';
import 'package:vibration/presentation/pages/search_page.dart';
import 'package:vibration/presentation/pages/sign_in_page.dart';
import 'package:vibration/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
      theme: theme,
    );
  }
}
