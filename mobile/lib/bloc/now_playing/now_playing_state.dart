part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingInitial extends NowPlayingState {}

class NowPlayingStateWithSong extends NowPlayingState {
  NowPlayingStateWithSong(this.mix, this.secondsIn);
  final Mix mix;
  final int secondsIn;

  @override
  List<Object> get props => [mix.name];
}