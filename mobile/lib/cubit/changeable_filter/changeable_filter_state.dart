part of 'changeable_filter_cubit.dart';

abstract class ChangeableFilterState extends Equatable {
  const ChangeableFilterState(this.mixes, this.names);

  @override
  List<Object> get props => [];
  final List<Mix> mixes;
  final List<String> names;
}

class ChangeableFilterInitial extends ChangeableFilterState {
  ChangeableFilterInitial(List<Mix> mixes, List<String> names)
      : super(
          mixes,
          names,
        );
}

class ChangeableFilterChanged extends ChangeableFilterState {
  final String nameChanged;
  final List<String> names;
  ChangeableFilterChanged(
    this.names,
    this.nameChanged,
    List<Mix> mixes,
  ) : super(mixes, names);
}
