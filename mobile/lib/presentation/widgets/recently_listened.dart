import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mix_tile.dart';

class RecentlyListened extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int discIndex = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
          child: Text(
            "Recently Listened",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(10, (index) {
                if (index % 2 != 0) {
                  if (discIndex == 3) discIndex = 0;
                  discIndex++;
                  return const SizedBox(width: 16); // TODO: should be a Mix
                } else {
                  return const SizedBox(width: 16);
                }
              }),
            ],
          ),
        ),
      ],
    );
  }
}
