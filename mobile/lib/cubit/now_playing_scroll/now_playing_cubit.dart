import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/presentation/pages/now_playing_page.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit(this._scrollController) : super(NowPlayingInitialState()) {
    _scrollController.addListener(_whenScrolled);
  }

  final ScrollController _scrollController;

  _whenScrolled() {
    if (state is NowPlayingEngagedState) {
      NowPlayingEngagedState engagedState = state as NowPlayingEngagedState;
      int songLength = 300;
      //int maxPixels = 542;
      var percentage = _scrollController.offset / _scrollController.position.maxScrollExtent;

      emit(
        engagedState.copyWith(
          percentage,
          engagedState.mix,
        ),
      );
    }
  }
}
