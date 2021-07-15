part of 'mixes_bloc.dart';

abstract class MixesEvent extends Equatable {
  const MixesEvent();

  @override
  List<Object> get props => [];
}

class MixesLoaded extends MixesEvent {}
