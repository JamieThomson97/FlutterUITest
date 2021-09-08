part of 'screens_cubit.dart';

abstract class ScreensState extends Equatable {
  const ScreensState(this.route);

  final String route;

  @override
  List<Object> get props => [route];
}

class ScreensDefault extends ScreensState {
  ScreensDefault() : super("home");
}

class Screen_NowPlaying extends ScreensState {
  Screen_NowPlaying() : super("now_playing");
}
