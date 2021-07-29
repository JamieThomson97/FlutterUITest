import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'now_playing_scroll_state.dart';

class NowPlayingScrollCubit extends Cubit<NowPlayingScrollState> {
  NowPlayingScrollCubit(this._scrollController) : super(NowPlayingScrollState(songPercentage: 0)) {
    _scrollController.addListener(_whenScrolled);
  }

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
