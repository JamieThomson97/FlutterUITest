import 'package:UITest/widgets/carousel.dart';
import 'package:UITest/widgets/discover_carousel.dart';
import 'package:UITest/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    final Container listSpacer = Container(
      height: screenHeight * 0.02,
    );

    return Material(
        child: ListView(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      children: <Widget>[
        TitleBar(),
        listSpacer,
        DiscoverCarousel(),
        listSpacer,
        Carousel(
          title: "Recently Listened",
        ),
        listSpacer,
        Carousel(
          title: "We think you'll like",
        ),
        listSpacer,
        Carousel(
          title: "Producers",
          isCircle: true,
        ),
      ],
    ));
  }
}
