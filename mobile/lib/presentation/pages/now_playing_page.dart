import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/cubit/now_playing_scroll/now_playing_scroll_cubit.dart';
import 'package:vibration/presentation/widgets/SongLengthScrollController.dart';
import 'package:vibration/presentation/widgets/marquee.dart';
import 'package:vibration/presentation/widgets/now_playing_scrollable.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  static ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NowPlayingScrollCubit(_scrollController),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(6),
            child: Stack(children: [
              BlocBuilder<NowPlayingScrollCubit, NowPlayingScrollState>(
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("resources/Now_Playing_Screen/KaytranadaLive.jpeg"),
                        alignment: Alignment(state.songPercentage.abs() * 0.4, 0),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                  );
                },
              ),
              Column(
                children: [
                  SizedBox(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white,
                            child: MarqueeWidget(
                              direction: Axis.horizontal,
                              text: Text(
                                "Kaytranada",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: Colors.white,
                            child: MarqueeWidget(
                              text: Text(
                                "Pitchfork 2018 - Paris",
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    height: 300,
                  ),
                  SizedBox(
                    height: 200,
                  ),
                  BlocBuilder<NowPlayingScrollCubit, NowPlayingScrollState>(
                    builder: (context, state) {
                      return Container(
                        color: Colors.white,
                        child: Text(
                          updatePercentage(state.songPercentage, 300),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 100,
                    child: NowPlayingScrollable(
                      scrollController: _scrollController,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  String updatePercentage(double percentage, int songLength) {
    percentage = percentage < 0 ? 0 : percentage;
    var seconds = (songLength * percentage).round();
    if (seconds > songLength) seconds = songLength;
    int minutes = (seconds / 60).truncate();
    var remainingSeconds = seconds - (minutes * 60);
    String minsString = minutes < 10 ? "0$minutes" : minutes.toString();
    String minsSecs = remainingSeconds < 10 ? "0$remainingSeconds" : remainingSeconds.toString();
    return "$minsString:$minsSecs | 05:00";
  }
}
