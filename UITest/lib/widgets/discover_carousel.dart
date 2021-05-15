import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'discover_item.dart';

class DiscoverCarousel extends StatelessWidget {
  const DiscoverCarousel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int discIndex = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            10,
            (index) {
              if (index % 2 != 0) {
                if (discIndex == 3) discIndex = 0;
                discIndex++;
                return DiscoverItem(index: discIndex);
              } else
                return const SizedBox(width: 16);
            },
          ),
        ],
      ),
    );
  }
}
