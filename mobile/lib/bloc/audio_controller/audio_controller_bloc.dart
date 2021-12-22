import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/model/music_player.dart';

part 'audio_controller_event.dart';
part 'audio_controller_state.dart';

class AudioControllerBloc extends Bloc<AudioControllerEvent, AudioControllerState> {
  AudioControllerBloc() : super(AudioControllerState.audioControllerInitial()) {
    _musicPlayer.playerTickerStream.listen(
      (event) {
        _durationChanged(event);
      },
    );

    on<MixStartedEvent>((event, emit) => _mixStarted(event, emit));
    on<MixPlayPausedEvent>((event, emit) => _mixPlayPaused(event, emit));
    on<MixTimestampChangedEvent>((event, emit) => _mixTimestampChanged(event, emit));
    on<MixSeekStartedEvent>((event, emit) => _ignoreSeeks = true);
    on<MixSeekEndedEvent>((event, emit) => _mixSeekEnded(event.songPercentage, emit));
    on<MixSongJumpedEvent>(
      (event, emit) {
        double percentage = event.songStart / state.mix!.length;
        _mixSeekEnded(percentage, emit);
      },
    );
  }

  late MusicPlayer _musicPlayer = MusicPlayer(new JustAudioWrapper());

  Future<void> _mixStarted(
    MixStartedEvent event,
    Emitter<AudioControllerState> emit,
  ) async {
    emit(
      AudioControllerState(
        mix: event.mix,
        secondsIn: 0,
        isPlaying: true,
        status: AudioControllerStatus.HasSong,
      ),
    );
    await _musicPlayer.initialiseMix(event.mix.path);
    _musicPlayer.playPauseMix();
  }

  Future<void> _mixPlayPaused(
    MixPlayPausedEvent event,
    Emitter<AudioControllerState> emit,
  ) async {
    emit(
      state.copyWith(
        AudioControllerStatus.HasSong,
        isPlaying: !_musicPlayer.isPlaying,
      ),
    );
    _musicPlayer.playPauseMix();
  }

  Future<void> _mixTimestampChanged(
    MixTimestampChangedEvent event,
    Emitter<AudioControllerState> emit,
  ) async {
    emit(
      state.copyWith(
        AudioControllerStatus.HasSong,
        secondsIn: event.secondsIn,
      ),
    );
  }

  bool _ignoreSeeks = false;
  Future<void> _mixSeekEnded(
    double songPercentage,
    Emitter<AudioControllerState> emit,
  ) async {
    var time = Duration(seconds: (state.mix!.length * songPercentage).round());
    _musicPlayer.seekMix(time);
    emit(
      state.copyWith(
        AudioControllerStatus.HasSong,
        secondsIn: (state.mix!.length * songPercentage).round(),
      ),
    );
    _ignoreSeeks = false;
  }

  void _durationChanged(Duration timestamp) {
    if (!_ignoreSeeks) this.add(MixTimestampChangedEvent(timestamp.inSeconds));
  }
}
