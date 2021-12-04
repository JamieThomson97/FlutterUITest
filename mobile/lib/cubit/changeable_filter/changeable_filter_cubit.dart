import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';

part 'changeable_filter_state.dart';

class ChangeableFilterCubit extends Cubit<ChangeableFilterState> {
  ChangeableFilterCubit() : super(ChangeableFilterInitial(List.empty()));
}
