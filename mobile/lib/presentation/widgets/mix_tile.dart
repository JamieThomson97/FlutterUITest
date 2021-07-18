import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/model/mix.dart';

class MixTile extends StatelessWidget {
  MixTile(this.mix);
  final Mix mix;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
            child: Image(
              image: AssetImage("resources/images/album_artwork_${new Random().nextInt(11) + 1}.jpeg"),
              fit: BoxFit.cover,
              height: 145,
              width: 145,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mix.name,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                mix.producer,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
