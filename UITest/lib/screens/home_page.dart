import 'package:UITest/widgets/carousel.dart';
import 'package:UITest/widgets/discover_carousel.dart';
import 'package:UITest/widgets/misc_widgets.dart';
import 'package:UITest/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListView(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      children: <Widget>[
        TitleBar(),
        ListSpacer(),
        DiscoverCarousel(),
        ListSpacer(),
        Carousel(
          title: "Recently Listened",
        ),
        ListSpacer(),
        Carousel(
          title: "We think you'll like",
        ),
        ListSpacer(),
        Carousel(
          title: "Producers",
          isCircle: true,
        ),
      ],
    ));
  }
}
