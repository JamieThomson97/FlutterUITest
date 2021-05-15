import 'dart:math';

import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ]),
      child: Image(
        image: AssetImage("resources/images/album_artwork_${new Random().nextInt(11) + 1}.jpeg"),
        fit: BoxFit.cover,
        height: 200,
        width: 400,
      ),
    );
  }
}
