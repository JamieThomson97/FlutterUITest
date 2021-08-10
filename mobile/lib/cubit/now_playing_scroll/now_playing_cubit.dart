import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/presentation/pages/now_playing_page.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit(this._scrollController, Mix mix) : super(NowPlayingState(songPercentage: 0, mix: mix)) {
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
