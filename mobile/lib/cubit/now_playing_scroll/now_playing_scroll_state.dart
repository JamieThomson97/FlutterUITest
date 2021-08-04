part of 'now_playing_scroll_cubit.dart';

class NowPlayingScrollState {
  NowPlayingScrollState({required this.songPercentage, required this.songLength}) {
    songLengthString = updatePercentage(100, songLength);
  }

  @override
  List<Object> get props => [];

  final double songPercentage;
  final int songLength;

  late String songLengthString;

  NowPlayingScrollState copyWith({double? songPercentage, int? songLength}) {
    return NowPlayingScrollState(
      songPercentage: songPercentage ?? this.songPercentage,
      songLength: songLength ?? this.songLength,
    );
  }

  static String updatePercentage(double percentage, int songLength) {
    percentage = percentage < 0 ? 0 : percentage;
    var seconds = (songLength * percentage).round();
    if (seconds > songLength) seconds = songLength;
    int minutes = (seconds / 60).truncate();
    var remainingSeconds = seconds - (minutes * 60);
    String minsString = minutes < 10 ? "0$minutes" : minutes.toString();
    String minsSecs = remainingSeconds < 10 ? "0$remainingSeconds" : remainingSeconds.toString();
    return "$minsString:$minsSecs";
  }
}
