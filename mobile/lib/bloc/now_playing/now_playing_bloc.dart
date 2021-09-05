import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  NowPlayingBloc() : super(NowPlayingInitial());

  @override
  Stream<NowPlayingState> mapEventToState(
    NowPlayingEvent event,
  ) async* {
    if (event is NowPlayingEventSongSelected) yield* mapNowPlayingStateWithSong(event);
  }

  Stream<NowPlayingState> mapNowPlayingStateWithSong(NowPlayingEventSongSelected event) async* {
    yield NowPlayingStateWithSong(event.mix, event.secondsIn);
  }
}
