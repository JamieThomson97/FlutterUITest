import 'package:flutter/material.dart';

import 'discover_item.dart';
import 'event_tile.dart';
import 'mix_tile.dart';

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Text(
            "Events",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            children: [
              ...List.generate(
                10,
                (index) {
                  if (index % 2 != 0) {
                    return EventTile();
                  } else {
                    return const SizedBox(width: 12);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
