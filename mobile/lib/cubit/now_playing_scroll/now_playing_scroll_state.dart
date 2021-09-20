part of 'now_playing_scroll_cubit.dart';

class NowPlayingScrollState {
  NowPlayingScrollState({required this.songPercentage, required this.mix}) {
    songLengthString = updatePercentage(100, mix.length);
    songPositionString = updatePercentage(songPercentage, mix.length);
  }

  @override
  List<Object> get props => [];

  final double songPercentage;
  late Mix mix;

  late String songLengthString;
  late String songPositionString;

  NowPlayingScrollState copyWith({double? songPercentage}) {
    return NowPlayingScrollState(
      songPercentage: songPercentage ?? this.songPercentage,
      mix: this.mix,
    );
  }

  static String updatePercentage(double percentage, int value) {
    int h, m, s;

    value = (value * percentage).truncate();

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft = m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft = s.toString().length < 2 ? "0" + s.toString() : s.toString();

    String result = "$hourLeft:$minuteLeft:$secondsLeft";

    return result;
  }
}
