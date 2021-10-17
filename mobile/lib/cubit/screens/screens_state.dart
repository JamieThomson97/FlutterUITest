part of 'screens_cubit.dart';

abstract class ScreensState extends Equatable {
  const ScreensState(this.route, this.time);
  final String route;
  final DateTime time;

  @override
  List<Object> get props => [route, time];
}

class ScreensDefault extends ScreensState {
  ScreensDefault() : super("home", DateTime.now());
}

class Screen_NowPlaying extends ScreensState {
  Screen_NowPlaying() : super("now_playing", DateTime.now());
}
