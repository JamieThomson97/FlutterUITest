part of 'audio_controller_bloc.dart';

abstract class AudioControllerEvent extends Equatable {
  const AudioControllerEvent();

  @override
  List<Object> get props => [];
}

class MixStartedEvent extends AudioControllerEvent {
  final Mix mix;

  MixStartedEvent(this.mix);
}

class MixPlayPausedEvent extends AudioControllerEvent {
  MixPlayPausedEvent();
}

class MixTimestampChangedEvent extends AudioControllerEvent {
  final int secondsIn;

  MixTimestampChangedEvent(this.secondsIn);
}

class MixSeekStartedEvent extends AudioControllerEvent {}

class MixSeekEndedEvent extends AudioControllerEvent {
  final double songPercentage;

  MixSeekEndedEvent(this.songPercentage);
}
