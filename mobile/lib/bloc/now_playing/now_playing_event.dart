part of 'now_playing_bloc.dart';

abstract class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();

  @override
  List<Object> get props => [];
}

class NowPlayingEventInitial extends NowPlayingEvent {}

class NowPlayingEventSongSelected extends NowPlayingEvent {
  NowPlayingEventSongSelected(this.mix, this.secondsIn);
  final Mix mix;
  final int secondsIn;
}
