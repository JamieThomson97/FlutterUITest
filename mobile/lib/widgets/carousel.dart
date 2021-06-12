import 'package:vibration/widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mix_tile.dart';
import 'mix_tile_circle.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    required this.title,
    this.isCircle,
  });

  final bool? isCircle;
  final String title;

  @override
  Widget build(BuildContext context) {
    bool actualIsCircle = isCircle != null && isCircle!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineText("Latest releases"),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(10, (index) {
                if (index % 2 != 0) {
                  return actualIsCircle ? MixTileCircle() : MixTile();
                } else {
                  return const SizedBox(width: 12);
                }
              }),
            ],
          ),
        ),
      ],
    );
  }
}
