import 'package:flutter/material.dart';

class ListSpacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.03,
    );
  }
}

class HeadlineText extends StatelessWidget {
  final String headline;

  HeadlineText(this.headline);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 0, 8),
      child: Text(
        headline,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
