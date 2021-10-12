part of 'audio_controller_bloc.dart';

abstract class AudioControllerState extends Equatable {
  const AudioControllerState();

  @override
  List<Object> get props => [];
}

class AudioControllerInitial extends AudioControllerState {}

class AudioControllerHasSong extends AudioControllerState {
  final Mix mix;
  final int secondsIn;
  final bool isPlaying;

  AudioControllerHasSong(this.mix, this.secondsIn, this.isPlaying);
}
