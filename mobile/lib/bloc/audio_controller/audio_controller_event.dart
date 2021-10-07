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

class MixPausedEvent extends AudioControllerEvent {}

class MixPlayedEvent extends AudioControllerEvent {}

class MixSeekedEvent extends AudioControllerEvent {}