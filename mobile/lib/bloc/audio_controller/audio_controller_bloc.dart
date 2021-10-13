import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/model/music_player.dart';

part 'audio_controller_event.dart';
part 'audio_controller_state.dart';

class AudioControllerBloc extends Bloc<AudioControllerEvent, AudioControllerState> {
  AudioControllerBloc() : super(AudioControllerState.audioControllerInitial()) {
    _musicPlayer.playerTickerStream.listen((event) {
      _durationChanged(event);
    });
  }

  late MusicPlayer _musicPlayer = MusicPlayer(new JustAudioWrapper());

  @override
  Stream<AudioControllerState> mapEventToState(
    AudioControllerEvent event,
  ) async* {
    if (event is MixStartedEvent) yield* _mixStarted(event);
    if (event is MixPlayPausedEvent) yield* _mixPlayPaused(event);
    if (event is MixTimestampChangedEvent) yield* _mixTimestampChanged(event);
  }

  Stream<AudioControllerState> _mixStarted(MixStartedEvent event) async* {
    yield AudioControllerState(
      mix: event.mix,
      secondsIn: 0,
      isPlaying: true,
      status: AudioControllerStatus.HasSong,
    );
    await _musicPlayer.initialiseMix(event.mix.path);
    _musicPlayer.playMix();
  }

  Stream<AudioControllerState> _mixPlayPaused(MixPlayPausedEvent event) async* {
    yield state.copyWith(
      AudioControllerStatus.HasSong,
      isPlaying: !event.isPlaying,
    );
    if (event.isPlaying)
      _musicPlayer.pauseMix();
    else
      _musicPlayer.playMix();
  }

  Stream<AudioControllerState> _mixTimestampChanged(MixTimestampChangedEvent event) async* {
    yield state.copyWith(
      AudioControllerStatus.HasSong,
      secondsIn: event.secondsIn,
    );
  }

  void _durationChanged(Duration timestamp) {
    this.add(MixTimestampChangedEvent(timestamp.inSeconds));
  }
}
