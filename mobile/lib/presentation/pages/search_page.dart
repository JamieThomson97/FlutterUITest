import 'package:vibration/presentation/widgets/carousel.dart';
import 'package:vibration/presentation/widgets/discover_carousel.dart';
import 'package:vibration/presentation/widgets/title_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

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
        TitleBar(userName: "Jamie"),
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
