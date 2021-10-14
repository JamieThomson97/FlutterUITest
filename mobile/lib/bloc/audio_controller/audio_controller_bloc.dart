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
    if (event is MixSeekStartedEvent) yield* _mixSeekStarted(event);
    if (event is MixSeekEndedEvent) yield* _mixSeekEnded(event);
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

  bool _ignoreSeeks = false;

  Stream<AudioControllerState> _mixSeekStarted(MixSeekStartedEvent event) async* {
    _ignoreSeeks = true;
  }

  Stream<AudioControllerState> _mixSeekEnded(MixSeekEndedEvent event) async* {
    var time = Duration(seconds: (state.mix!.length * event.songPercentage).round());
    _musicPlayer.seekMix(time);
    yield state.copyWith(
      AudioControllerStatus.HasSong,
      secondsIn: (state.mix!.length * event.songPercentage).round(),
    );
    _ignoreSeeks = false;
  }

  void _durationChanged(Duration timestamp) {
    if (!_ignoreSeeks) this.add(MixTimestampChangedEvent(timestamp.inSeconds));
  }
}
