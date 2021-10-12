import 'package:just_audio/just_audio.dart';

class MusicPlayer {
  final IAudioPlayer _player;

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
}

class JustAudioWrapper implements IAudioPlayer {
  AudioPlayer player = AudioPlayer();

  JustAudioWrapper() {
    player.positionStream.listen((event) {
      onChange(event);
    });
  }

  void onChange(Duration timeStamp) {
    int idk;
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
}
