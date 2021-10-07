import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/model/music_player.dart';

part 'audio_controller_event.dart';
part 'audio_controller_state.dart';

class AudioControllerBloc extends Bloc<AudioControllerEvent, AudioControllerState> {
  AudioControllerBloc() : super(AudioControllerInitial());

  late MusicPlayer _musicPlayer = MusicPlayer();

  @override
  Stream<AudioControllerState> mapEventToState(
    AudioControllerEvent event,
  ) async* {
    if (event is MixStartedEvent) yield* _mixStarted(event);
  }

  Stream<AudioControllerState> _mixStarted(MixStartedEvent event) async* {
    _musicPlayer.initialiseMix(event.mix.path);
    yield AudioControllerHasSong(event.mix, 0);
  }
}
