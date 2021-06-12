import 'dart:math';

import 'package:vibration/widgets/carousel.dart';
import 'package:vibration/widgets/discover_carousel.dart';
import 'package:vibration/widgets/event_tile.dart';
import 'package:vibration/widgets/events_list.dart';
import 'package:vibration/widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ArtistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(1),
                      spreadRadius: 8,
                      blurRadius: 8,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Image(
                  image: AssetImage("resources/images/album_artwork_4.jpeg"),
                  fit: BoxFit.fill,
                  height: 450,
                ),
              ),
              Positioned(
                bottom: -25,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    child: Text(
                      "Follow",
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    onPressed: () => {},
                  ),
                ),
              ),
            ],
          ),
          ListSpacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              children: [
                Expanded(child: ArtistInfoColumn(18, "Mixes")),
                Expanded(child: ArtistInfoColumn(34000, "Followers")),
                Expanded(child: ArtistInfoColumn(218, "Following")),
              ],
            ),
          ),
          ListSpacer(),
          Carousel(title: "Latest releases"),
          ListSpacer(),
          HeadlineText("Events"),
          Column(
            children: [
              ...List.generate(10, (index) {
                if (index % 2 != 1) {
                  return EventTile();
                } else {
                  return const SizedBox(height: 25);
                }
              }),
            ],
          )
        ],
      ),
    );
  }
}

class ArtistInfoColumn extends StatelessWidget {
  ArtistInfoColumn(this.number, this.property);

  final int number;
  final String property;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          NumberFormat("#,###").format(number).toString(),
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500, color: Colors.blue[400]),
        ),
        Container(height: 10),
        Text(
          property,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey[700]),
        ),
        Container(height: 10),
      ],
    );
  }
}
