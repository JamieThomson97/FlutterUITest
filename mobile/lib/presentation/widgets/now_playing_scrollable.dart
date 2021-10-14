import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/bloc/audio_controller/audio_controller_bloc.dart';
import 'package:vibration/cubit/now_playing_scroll/now_playing_scroll_cubit.dart';

class NowPlayingScrollable extends StatelessWidget {
  const NowPlayingScrollable({
    Key? key,
    required this.scrollController,
    required this.songLength,
  }) : super(key: key);

  final ScrollController scrollController;
  final int songLength;

  @override
  Widget build(BuildContext context) {
    int itemCount = (songLength / 4).floor();
    return BlocListener<AudioControllerBloc, AudioControllerState>(
      listener: (context, state) {
        if (state.status == AudioControllerStatus.HasSong) {
          scrollController.animateTo(
            _getScrollOffset(state.secondsIn),
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      },
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: ((BuildContext context, int index) {
          if (index == 1 || index == itemCount - 1) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2,
            );
          }
          if (index & 2 == 0)
            return Align(
              child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                height: 1,
                width: 0.5,
                // child: Text('Item: '),
              ),
            );
          else
            return BlocBuilder<NowPlayingScrollCubit, NowPlayingScrollState>(
              buildWhen: (prevState, currentState) {
                return _isOver(itemCount, index, prevState.songPercentage) !=
                    _isOver(itemCount, index, currentState.songPercentage);
              },
              builder: (context, state) {
                int trig = (index / 50).floor();
                int dunno = trig % 2;
                double height = index % 50;
                if (dunno == 1) height = 50 - height;
                height = height + 30;
                return Align(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    color: _getColour(itemCount, index, state.songPercentage),
                    height: height,
                    width: 1.2,
                  ),
                );
              },
            );
        }),
      ),
    );
  }

  // Todo: improve performance
  static bool areCurrentlyOver = false;

  static bool _isOver(int itemCount, int index, double percentage) {
    return percentage * itemCount > index;
  }

  static Color _getColour(int itemCount, int index, double percentage) {
    var isOver = percentage * itemCount > index;
    // if (isOver != areCurrentlyOver) {
    //   print("index: $index , itemCount as percentage: ${percentage * index} ,percentage: $percentage, isOver: $isOver");
    //   areCurrentlyOver = isOver;
    // }
    return isOver ? Colors.red : Colors.green;
  }

  double _getScrollOffset(int time) {
    var percentage = time / songLength;
    var something = scrollController.position.maxScrollExtent * percentage;
    print("Autoscrolling to $something");
    return something;
  }
}
