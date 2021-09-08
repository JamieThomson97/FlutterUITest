import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'screens_state.dart';

class ScreensCubit extends Cubit<ScreensState> {
  ScreensCubit() : super(ScreensDefault());
}
