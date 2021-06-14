// this is a horrible hack because I don't want to get into state management yet

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SongLengthScrollController extends StatefulWidget {
  const SongLengthScrollController(Key? key, this.controller) : super(key: key);

  final ScrollController controller;
  @override
  _SongLengthScrollControllerState createState() => _SongLengthScrollControllerState(controller);
}

class _SongLengthScrollControllerState extends State<SongLengthScrollController> {
  _SongLengthScrollControllerState(this.controller) {
    controller.addListener(_scrollListener);
  }

  String text = "00:00";

  void updatePercentage(double percentage, int songLength) {
    percentage = percentage < 0 ? 0 : percentage;
    var seconds = (songLength * percentage).round();
    if (seconds > songLength) seconds = songLength;
    int minutes = (seconds / 60).truncate();
    var remainingSeconds = seconds - (minutes * 60);
    String minsString = minutes < 10 ? "0$minutes" : minutes.toString();
    String minsSecs = remainingSeconds < 10 ? "0$remainingSeconds" : remainingSeconds.toString();
    String result = "$minsString:$minsSecs";
    this.setState(() {
      text = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  ScrollController controller;

  _scrollListener() {
    int songLength = 300;
    //int maxPixels = 542;
    var percentage = controller.offset / controller.position.maxScrollExtent;

    updatePercentage(percentage, songLength);
  }
}
