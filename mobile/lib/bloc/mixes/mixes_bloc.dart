import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/repository/mixes_repository.dart';

part 'mixes_event.dart';
part 'mixes_state.dart';

class MixesBloc extends Bloc<MixesEvent, MixesState> {
  MixesBloc(this._mixesRepository, this._collection) : super(MixesLoadInProgress()) {
    // sleep(Duration(seconds: 1));
    add(MixesLoaded(_collection));
  }

  final IMixesRepository _mixesRepository;
  final String _collection;

  @override
  Stream<MixesState> mapEventToState(
    MixesEvent event,
  ) async* {
    if (event is MixesLoaded) yield* _mapMixesLoadedToState(event.collection);
  }

  Stream<MixesState> _mapMixesLoadedToState(String collection) async* {
    try {
      final mixes = await _mixesRepository.loadMixes(collection);
      yield MixesLoadSuccessful(mixes);
    } catch (_) {
      yield MixesLoadFailed();
    }
  }
}
