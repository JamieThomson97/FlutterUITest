import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/bloc/audio_controller/audio_controller_bloc.dart';
import 'package:vibration/cubit/screens/screens_cubit.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/presentation/widgets/misc.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioControllerBloc, AudioControllerState>(
      builder: (blockContext, state) {
        return state.status == AudioControllerStatus.HasSong ? PopulatedNowPlaying(state: state) : Text(" ");
      },
    );
  }
}

class PopulatedNowPlaying extends StatelessWidget {
  const PopulatedNowPlaying({Key? key, required this.state}) : super(key: key);

  final AudioControllerState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70,
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(state.mix!.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.1),
                child: InkWell(
                  onTap: () => _pushToNowPlaying(context, state),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Misc.getBackgroundedText(
                                state.mix!.name,
                              ),
                              SizedBox(height: 2),
                              Misc.getBackgroundedText(
                                state.mix!.producer,
                              )
                            ],
                          ),
                          onTap: () => _pushToNowPlaying(context, state),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: IconButton(
                          onPressed: () {
                            _onPlayPausePressed(context);
                          },
                          icon: state.isPlaying
                              ? Icon(
                                  Icons.pause_outlined,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.play_arrow_outlined,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<AudioControllerBloc, AudioControllerState>(
          builder: (context, state) {
            return Container(
              color: state.mix!.color,
              height: 4,
              width: (state.secondsIn / state.mix!.length) * MediaQuery.of(context).size.width,
            );
          },
        )
      ],
    );
  }

  void _pushToNowPlaying(BuildContext context, AudioControllerState state) {
    if (state.status == AudioControllerStatus.NoSong) return;
    try {
      var cubit = context.read<ScreensCubit>();
      cubit.emit(Screen_NowPlaying());
    } catch (e) {
      int test;
    }
  }

  void _onPlayPausePressed(BuildContext context) {
    var bloc = context.read<AudioControllerBloc>();
    bloc.add(MixPlayPausedEvent());
  }
}
