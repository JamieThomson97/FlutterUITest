part of 'now_playing_cubit.dart';

abstract class NowPlayingState {}

class NowPlayingInitialState extends NowPlayingState {
  NowPlayingInitialState();
  @override
  NowPlayingState copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}

class NowPlayingEngagedState extends NowPlayingState {
  NowPlayingEngagedState(this.mix);
  Mix mix;
  double songPercentage = 0;

  NowPlayingEngagedState.progressed(this.mix, this.songPercentage);

  NowPlayingEngagedState copyWith(double? songPercentage, Mix? mix) {
    return NowPlayingEngagedState.progressed(
      mix ?? this.mix,
      songPercentage ?? this.songPercentage,
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

// class NowPlayingState {
//   NowPlayingState({required this.songPercentage, required this.mix}) {
//     songLengthString = updatePercentage(100, mix.length);
//   }

//   @override
//   List<Object> get props => [];

//   final double songPercentage;
//   late Mix mix;

//   late String songLengthString;

//   NowPlayingState copyWith({double? songPercentage}) {
//     return NowPlayingState(
//       songPercentage: songPercentage ?? this.songPercentage,
//       mix: this.mix,
//     );
//   }
// }

class NowPlayingError extends Error {
  final String message;
  NowPlayingError(this.message);
}
