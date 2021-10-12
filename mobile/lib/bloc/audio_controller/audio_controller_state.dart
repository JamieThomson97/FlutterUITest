part of 'audio_controller_bloc.dart';

enum AudioControllerStatus { HasSong, NoSong }

class AudioControllerState {
  final Mix? mix;
  final int secondsIn;
  final bool isPlaying;
  final AudioControllerStatus status;

  static AudioControllerState audioControllerInitial() {
    return AudioControllerState();
  }

  AudioControllerState({
    this.mix,
    this.secondsIn = 0,
    this.isPlaying = false,
    this.status = AudioControllerStatus.NoSong,
  });

  AudioControllerState copyWith(
    AudioControllerStatus status, {
    Mix? mix,
    int? secondsIn,
    bool? isPlaying,
  }) {
    return AudioControllerState(
      mix: mix ?? this.mix,
      secondsIn: secondsIn ?? this.secondsIn,
      isPlaying: isPlaying ?? this.isPlaying,
      status: status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (!(other is AudioControllerState)) return false;

    return other.isPlaying == this.isPlaying &&
        other.status == this.status &&
        other.secondsIn == this.secondsIn &&
        other.mix!.id == this.mix!.id;
  }

  @override
  int get hashCode => this.isPlaying.hashCode ^ this.status.hashCode ^ this.secondsIn.hashCode ^ this.mix.hashCode;
}

// class AudioControllerInitial extends AudioControllerState {}

// class AudioControllerHasSong extends AudioControllerState {
//   AudioControllerHasSong(this.mix, this.secondsIn, this.isPlaying);
// }
