part of 'changeable_filter_cubit.dart';

abstract class ChangeableFilterState extends Equatable {
  const ChangeableFilterState(this.mixes);

  @override
  List<Object> get props => [];
  final List<Mix> mixes;
}

class ChangeableFilterInitial extends ChangeableFilterState {
  ChangeableFilterInitial(List<Mix> mixes) : super(mixes);
}

class ChangeableFilterChanged extends ChangeableFilterState {
  final int index;

  ChangeableFilterChanged(this.index, List<Mix> mixes) : super(mixes);
}
