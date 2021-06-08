import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoverItem extends StatelessWidget {
  DiscoverItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        child: Image(
          image: AssetImage("resources/images/album_artwork_${new Random().nextInt(11) + 1}.jpeg"),
          fit: BoxFit.cover,
          height: 250,
          width: 150,
        ),
      ),
    );
  }
}
