import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_scroll_state.dart';

class NowPlayingScrollCubit extends Cubit<NowPlayingScrollState> {
  NowPlayingScrollCubit() : super(NowPlayingScrollInitial());
}
