part of 'changeable_filter_cubit.dart';

abstract class ChangeablefilterState extends Equatable {
  const ChangeablefilterState();

  @override
  List<Object> get props => [];
}

class ChangeableFilterInitial extends ChangeablefilterState {}

class ChangeableFilterChanged extends ChangeablefilterState {
  final int index;

  ChangeableFilterChanged(this.index);
}
