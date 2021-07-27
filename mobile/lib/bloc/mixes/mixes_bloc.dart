import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/repository/mixes_repository.dart';

part 'mixes_event.dart';
part 'mixes_state.dart';

class MixesBloc extends Bloc<MixesEvent, MixesState> {
  MixesBloc(this._mixesRepository) : super(MixesLoadInProgress()) {
    sleep(Duration(seconds: 1));
    add(MixesLoaded());
  }

  final IMixesRepository _mixesRepository;

  @override
  Stream<MixesState> mapEventToState(
    MixesEvent event,
  ) async* {
    if (event is MixesLoaded) yield* _mapMixesLoadedToState();
  }

  Stream<MixesState> _mapMixesLoadedToState() async* {
    try {
      final mixes = await _mixesRepository.loadMixes();
      yield MixesLoadSuccessful(mixes);
    } catch (_) {
      yield MixesLoadFailed();
    }
  }
}
