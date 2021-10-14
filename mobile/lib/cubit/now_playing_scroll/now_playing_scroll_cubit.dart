import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:vibration/bloc/audio_controller/audio_controller_bloc.dart';
import 'package:vibration/model/mix.dart';

part 'now_playing_scroll_state.dart';

class NowPlayingScrollCubit extends Cubit<NowPlayingScrollState> {
  NowPlayingScrollCubit(this._scrollController, Mix mix, this.audioControllerBloc)
      : super(NowPlayingScrollState(
          songPercentage: 0,
          mix: mix,
        )) {
    _scrollController.addListener(_whenScrolled);
  }

  final AudioControllerBloc audioControllerBloc;
  final ScrollController _scrollController;

  void updatePercentage(double percentage, int songLength) {
    percentage = percentage < 0 ? 0 : percentage;
    var seconds = (songLength * percentage).round();
    if (seconds > songLength) seconds = songLength;
    int minutes = (seconds / 60).truncate();
    var remainingSeconds = seconds - (minutes * 60);
    String minsString = minutes < 10 ? "0$minutes" : minutes.toString();
    String minsSecs = remainingSeconds < 10 ? "0$remainingSeconds" : remainingSeconds.toString();
    String result = "$minsString:$minsSecs";
  }

  _whenScrolled() {
    int songLength = 300;
    //int maxPixels = 542;
    var percentage = _scrollController.offset / _scrollController.position.maxScrollExtent;

    emit(state.copyWith(songPercentage: percentage));
  }
}
