import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/model/music_player.dart';
import 'package:vibration/test/mock_classes.dart';

part 'audio_controller_event.dart';
part 'audio_controller_state.dart';

class AudioControllerBloc extends Bloc<AudioControllerEvent, AudioControllerState> {
  AudioControllerBloc() : super(AudioControllerInitial());

  late MusicPlayer _musicPlayer = MusicPlayer(new JustAudioWrapper());

  @override
  Stream<AudioControllerState> mapEventToState(
    AudioControllerEvent event,
  ) async* {
    if (event is MixStartedEvent) yield* _mixStarted(event);
  }

  Stream<AudioControllerState> _mixStarted(MixStartedEvent event) async* {
    yield AudioControllerHasSong(event.mix, 0, true);
    await _musicPlayer.initialiseMix(event.mix.path);
    _musicPlayer.playMix();
  }

  Stream<AudioControllerState> _mixPlayPaused(MixPlayPausedEvent event) async* {
    if (state is AudioControllerHasSong) {
      yield AudioControllerHasSong(MockMixes.getMockMixes(1, "ds").first, 0, true);
      _musicPlayer.pauseMix();
    }
  }
}
