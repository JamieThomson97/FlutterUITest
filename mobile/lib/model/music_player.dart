// import 'package:just_audio/just_audio.dart';

class MusicPlayer {
  final IAudioPlayer _player;

  MusicPlayer(this._player);

  void initialiseMix(String path) async {
    var duration = await _player.setFilePath(path);
  }

  void playMix() {
    _player.play();
  }
}

abstract class IAudioPlayer {
  int setFilePath(String path);
  void play();
}

class MockAudioPlayer implements IAudioPlayer {
  @override
  void play() {
    // TODO: implement play
  }

  @override
  int setFilePath(String path) {
    return -1;
  }
}
