import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String userName;
  const TitleBar({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
      child: Row(
        children: [
          Text(
            'Hi $userName',
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
