import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vibration/bloc/audio_controller/audio_controller_bloc.dart';
import 'package:vibration/cubit/now_playing_scroll/now_playing_scroll_cubit.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/presentation/widgets/marquee.dart';
import 'package:vibration/presentation/widgets/now_playing_scrollable.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  static ScrollController _scrollController = ScrollController();
  static PanelController _panelScrollerController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Dismissible(
        direction: DismissDirection.down,
        key: const Key('key'),
        onDismissed: (_) => Navigator.of(context).pop(),
        child: BlocBuilder<AudioControllerBloc, AudioControllerState>(
          builder: (context, audioControllerState) {
            return SlidingUpPanel(
              backdropEnabled: true,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3.0,
                  color: Colors.black,
                ),
              ],
              color: Colors.transparent,
              controller: _panelScrollerController,
              maxHeight: 350,
              minHeight: 0,
              panelBuilder: (sc) => _panel(sc, context, audioControllerState.mix!.songs),
              body: SafeArea(
                child: Container(
                  // padding: EdgeInsets.all(6),
                  child: Stack(
                    children: [
                      BlocProvider(
                        create: (context) => NowPlayingScrollCubit(
                          _scrollController,
                          audioControllerState.mix!,
                          context.read<AudioControllerBloc>(),
                        ),
                        child: BlocBuilder<NowPlayingScrollCubit, NowPlayingScrollState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                context.read<AudioControllerBloc>().add(MixPlayPausedEvent());
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("resources/Now_Playing_Screen/KaytranadaLive.jpeg"),
                                        alignment: Alignment(state.songPercentage.abs() * 0.4, 0),
                                      ),
                                    ),
                                    padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                  ),
                                  TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: 0.0,
                                      end: audioControllerState.isPlaying ? 0 : 12.0,
                                    ),
                                    duration: const Duration(milliseconds: 250),
                                    builder: (_, value, child) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
                                        child: child,
                                      );
                                    },
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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
                                  BlocBuilder<AudioControllerBloc, AudioControllerState>(
                                    builder: (context, state) {
                                      return Container(
                                        color: Colors.white,
                                        child: MarqueeWidget(
                                          direction: Axis.horizontal,
                                          text: Text(
                                            state.mix!.producer,
                                            style: Theme.of(context).textTheme.headline5,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  BlocBuilder<AudioControllerBloc, AudioControllerState>(
                                    // todo: buildWhen
                                    builder: (context, state) {
                                      return Container(
                                        color: Colors.white,
                                        child: MarqueeWidget(
                                          text: Text(
                                            state.mix!.event,
                                            style: Theme.of(context).textTheme.headline6,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  BlocBuilder<AudioControllerBloc, AudioControllerState>(
                                    // todo: buildWhen
                                    builder: (context, state) {
                                      return Container(
                                        color: Colors.white,
                                        child: MarqueeWidget(
                                          text: Text(
                                            DateFormat('yyyy-MM-dd').format(state.mix!.dateUploaded),
                                            style: Theme.of(context).textTheme.headline5,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            height: 340,
                          ),
                          BlocBuilder<AudioControllerBloc, AudioControllerState>(
                            buildWhen: (prev, current) => prev.isPlaying != current.isPlaying,
                            builder: (context, state) {
                              return Center(
                                child: AnimatedOpacity(
                                  duration: new Duration(milliseconds: 300),
                                  opacity: state.isPlaying ? 0 : 1,
                                  child: InkWell(
                                    child: Icon(
                                      Icons.play_circle_fill_rounded,
                                      color: Colors.white,
                                      size: 100,
                                    ),
                                    onTap: () {
                                      context.read<AudioControllerBloc>().add(MixPlayPausedEvent());
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          BlocBuilder<AudioControllerBloc, AudioControllerState>(
                            buildWhen: (prev, current) {
                              return current.secondsIn == 0;
                            },
                            builder: (context, state) {
                              return BlocProvider(
                                create: (context) => NowPlayingScrollCubit(
                                  _scrollController,
                                  state.mix!,
                                  context.read<AudioControllerBloc>(),
                                ),
                                child: BlocBuilder<NowPlayingScrollCubit, NowPlayingScrollState>(
                                  builder: (context, state) {
                                    return Container(
                                      color: Colors.white,
                                      child: Text(
                                        "${state.songPositionString} | ${state.songLengthString}",
                                        style: Theme.of(context).textTheme.headline5,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          BlocBuilder<AudioControllerBloc, AudioControllerState>(
                            // todo: this won't work
                            buildWhen: (prev, current) {
                              return current.secondsIn == 0;
                            },
                            builder: (context, state) {
                              return BlocProvider(
                                create: (context) => NowPlayingScrollCubit(
                                  _scrollController,
                                  state.mix!,
                                  context.read<AudioControllerBloc>(),
                                ),
                                child: Container(
                                  height: 100,
                                  child: NowPlayingScrollable(
                                    scrollController: _scrollController,
                                    songLength: state.mix!.length,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                NowPlayingPageIcon(
                                  icon: Icons.favorite_border_rounded,
                                  onPressed: () {},
                                ),
                                // todo : get better repost icon
                                NowPlayingPageIcon(
                                  icon: Icons.sync_alt_outlined,
                                  onPressed: () {},
                                ),
                                NowPlayingPageIcon(
                                  icon: Icons.upcoming_rounded,
                                  onPressed: () {
                                    _panelScrollerController.open();
                                  },
                                ),
                                NowPlayingPageIcon(
                                  icon: Icons.more_horiz_rounded,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _panel(ScrollController sc, BuildContext context, List<Song> songs) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.9),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: songs.length,
          itemBuilder: (BuildContext context, int index) {
            return MixSongItem(
              song: songs[index],
            );
          },
        ),
      ),
    );
  }
}

class MixSongItem extends StatelessWidget {
  const MixSongItem({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    var textColor = Colors.white;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.songName,
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                SizedBox(height: 5),
                Text(
                  song.artistName,
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
              ],
            ),
            Spacer(),
            Text(
              "${song.startSeconds}",
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            Text(
              " - ",
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            Text(
              "${song.endSeconds}",
              style: TextStyle(fontSize: 16, color: textColor),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
          height: 1,
          width: queryData.size.width,
          decoration: BoxDecoration(color: Colors.grey),
        )
      ],
    );
  }
}

class NowPlayingPageIcon extends StatelessWidget {
  const NowPlayingPageIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
      ),
      iconSize: 30,
      color: Colors.white,
    );
  }
}
