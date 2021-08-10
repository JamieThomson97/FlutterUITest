import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/cubit/now_playing_scroll/now_playing_cubit.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/presentation/widgets/SongLengthScrollController.dart';
import 'package:vibration/presentation/widgets/marquee.dart';
import 'package:vibration/presentation/widgets/now_playing_scrollable.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  static ScrollController _scrollController = ScrollController();
  static Mix mix = Mix(
    "id",
    "name",
    "Kaytranada",
    "Pitchfork 2018 - Paris",
    "resources/Now_Playing_Screen/KaytranadaLive.jpeg",
    DateTime.now(),
    300,
    "05:00",
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NowPlayingCubit(_scrollController),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(6),
            child: Stack(children: [
              BlocBuilder<NowPlayingCubit, NowPlayingState>(builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(mix.imageUrl),
                      alignment: Alignment(
                        state is NowPlayingEngagedState ? state.songPercentage.abs() * 0.4 : 0.4,
                        0,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                );
              }),
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
                                mix.producer,
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
                                mix.event,
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.left,
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
                                mix.dateUploaded.toString(),
                                style: Theme.of(context).textTheme.headline5,
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
                  BlocBuilder<NowPlayingCubit, NowPlayingState>(
                    builder: (context, state) {
                      if (state is NowPlayingEngagedState) {
                        return Container(
                          color: Colors.white,
                          child: Text(
                            "${updatePercentage(state.songPercentage, mix.length)} | ${state.mix.songLengthString}",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        );
                      }
                      throw new NowPlayingError("NowPlayingPage112");
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

  static String updatePercentage(double percentage, int songLength) {
    percentage = percentage < 0 ? 0 : percentage;
    var seconds = (songLength * percentage).round();
    if (seconds > songLength) seconds = songLength;
    int minutes = (seconds / 60).truncate();
    var remainingSeconds = seconds - (minutes * 60);
    String minsString = minutes < 10 ? "0$minutes" : minutes.toString();
    String minsSecs = remainingSeconds < 10 ? "0$remainingSeconds" : remainingSeconds.toString();
    return "$minsString:$minsSecs";
  }
}
