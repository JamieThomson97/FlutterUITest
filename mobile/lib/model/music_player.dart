import 'package:just_audio/just_audio.dart';

class MusicPlayer {
  final _player = AudioPlayer();

  MusicPlayer() {}

  void initialiseMix(String path) async {
    var duration = await _player.setFilePath(path);
  }

  void playMix() {
    _player.play();
  }
}
