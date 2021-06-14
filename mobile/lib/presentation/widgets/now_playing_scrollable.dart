import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NowPlayingScrollable extends StatefulWidget {
  NowPlayingScrollable({Key? key}) : super(key: key);

  @override
  _NowPlayingScrollableState createState() => _NowPlayingScrollableState();
}

class _NowPlayingScrollableState extends State<NowPlayingScrollable> {
  Color _color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: _color,
      height: 30,
      width: 1,
    );
  }

  void scrolled(bool overTheLine) {
    this.setState(() {
      _color = overTheLine ? Colors.amber : Colors.white;
    });
  }
}
