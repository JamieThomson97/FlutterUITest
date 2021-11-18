import 'dart:async';

import 'package:just_audio/just_audio.dart';

class MusicPlayer {
  final IAudioPlayer _player;
  Stream<Duration> get playerTickerStream => _player.playerTickerStream;
  bool get isPlaying => _player.isPlaying;

  MusicPlayer(this._player);

  Future<void> initialiseMix(String path) async {
    var duration = await _player.setFilePath(path);
  }

  void playPauseMix() {
    if (_player.isPlaying)
      _player.pause();
    else
      _player.play();
  }

  void seekMix(Duration timestamp) {
    _player.seek(timestamp);
  }
}

abstract class IAudioPlayer {
  Future<Duration?> setFilePath(String path);
  void play();
  void pause();
  void seek(Duration position);

  bool get isPlaying;

  Stream<Duration> get playerTickerStream;
}

class JustAudioWrapper implements IAudioPlayer {
  AudioPlayer player = AudioPlayer();

// todo: Close sink
  final StreamController<Duration> _playerTicker = StreamController<Duration>();
  Stream<Duration> get playerTickerStream => _playerTicker.stream;

  late int secondsIn = -1;

  JustAudioWrapper() {
    player.positionStream.listen((event) {
      if (player.audioSource != null) {
        if (secondsIn != event.inSeconds) {
          secondsIn = event.inSeconds;
          onChange(event);
        }
      }
    });
  }

  void onChange(Duration timeStamp) {
    _playerTicker.sink.add(timeStamp);
  }

  @override
  void play() {
    player.play();
  }

  @override
  Future<Duration?> setFilePath(String path) async {
    var result = await player.setAsset(path);
    return result;
  }

  @override
  void pause() {
    player.pause();
  }

  @override
  void seek(Duration position) {
    player.seek(position);
  }

  @override
  bool get isPlaying => player.playing;
}
