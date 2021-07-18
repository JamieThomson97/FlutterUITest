part of 'mixes_bloc.dart';

abstract class MixesState extends Equatable {
  const MixesState();

  @override
  List<Object> get props => [];
}

class MixesInitial extends MixesState {}

class MixesLoadInProgress extends MixesState {}

class MixesLoadSuccessful extends MixesState {
  final List<Mix> mixes;

  const MixesLoadSuccessful(this.mixes);
}

class MixesLoadFailed extends MixesState {}
