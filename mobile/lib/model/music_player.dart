import 'package:just_audio/just_audio.dart';

class MusicPlayer {
  final player = AudioPlayer();

  MusicPlayer() {}

  void initialiseMix(String path) async {
    var duration = await player.setFilePath(path);
  }
}
