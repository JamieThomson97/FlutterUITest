import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/bloc/now_playing/now_playing_bloc.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingBloc, NowPlayingState>(
      builder: (context, state) {
        return Container(
            height: 80,
            color: state is NowPlayingStateWithSong ? state.mix.color : Colors.grey,
            child: SizedBox.expand(
                child: state is NowPlayingStateWithSong
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                            child: Icon(Icons.play_arrow_outlined),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.mix.name),
                              Text(state.mix.producer),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("${state.mix.length} /"), Text(state.secondsIn.toString())],
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Text("Now playing"),
                      )));
      },
    );
  }
}
