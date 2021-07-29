part of 'now_playing_scroll_cubit.dart';

class NowPlayingScrollState {
  const NowPlayingScrollState({required this.songPercentage});

  @override
  List<Object> get props => [];

  final double songPercentage;

  NowPlayingScrollState copyWith({double? songPercentage}) {
    return NowPlayingScrollState(songPercentage: songPercentage ?? this.songPercentage);
  }
}
