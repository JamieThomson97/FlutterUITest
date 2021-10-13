import 'dart:async';

import 'package:just_audio/just_audio.dart';

class MusicPlayer {
  final IAudioPlayer _player;
  Stream<Duration> get playerTickerStream => _player.playerTickerStream;

  MusicPlayer(this._player);

  Future<void> initialiseMix(String path) async {
    var duration = await _player.setFilePath(path);
  }

  void playMix() {
    _player.play();
  }

  void pauseMix() {
    _player.pause();
  }
}

abstract class IAudioPlayer {
  Future<Duration?> setFilePath(String path);
  void play();
  void pause();

  Stream<Duration> get playerTickerStream;
}

class JustAudioWrapper implements IAudioPlayer {
  AudioPlayer player = AudioPlayer();

// todo: Close sink
  final StreamController<Duration> _playerTicker = StreamController<Duration>();
  Stream<Duration> get playerTickerStream => _playerTicker.stream;

  JustAudioWrapper() {
    player.positionStream.listen((event) {
      if (player.audioSource != null) onChange(event);
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
}

class MockAudioPlayer implements IAudioPlayer {
  @override
  void play() {
    // TODO: implement play
  }

  @override
  Future<Duration?> setFilePath(String path) {
    // TODO: implement setFilePath
    throw UnimplementedError();
  }

  @override
  void pause() {
    // TODO: implement Pause
  }

  @override
  // TODO: implement playerTickerStream
  Stream<Duration> get playerTickerStream => throw UnimplementedError();
}
