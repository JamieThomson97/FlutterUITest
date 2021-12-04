import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'changeable_filter_state.dart';

class ChangeableFilterCubit extends Cubit<ChangeablefilterState> {
  ChangeableFilterCubit() : super(ChangeableFilterInitial());
}
