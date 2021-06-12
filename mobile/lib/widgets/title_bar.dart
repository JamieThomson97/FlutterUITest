import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
      child: Row(
        children: [
          Text(
            'Discover',
            style: Theme.of(context).textTheme.headline5,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.settings,
              size: 40,
            ), // TODO : Get better settings icon (DesignCode?)
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
