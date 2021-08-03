// https://stackoverflow.com/questions/51772543/how-to-make-a-text-widget-act-like-marquee-when-the-text-overflows-in-flutter

import 'package:flutter/cupertino.dart';

class MarqueeWidget extends StatefulWidget {
  final Text text;
  final Axis direction;
  final Duration backDuration, pauseDuration;
  final int length;

  MarqueeWidget({
    required this.text,
    required this.length,
    this.direction: Axis.horizontal,
    this.backDuration: const Duration(milliseconds: 800),
    this.pauseDuration: const Duration(milliseconds: 800),
  });

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState(
        text,
        Duration(seconds: (1 / 16 * this.length).round()),
      );
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;

  _MarqueeWidgetState(this.text, this.animationDuration);

  Text text;
  Duration animationDuration;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0);
    WidgetsBinding.instance!.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: text,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients)
        await scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: animationDuration, curve: Curves.ease);
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients)
        await scrollController.animateTo(0.0, duration: widget.backDuration, curve: Curves.easeOut);
    }
  }
}
