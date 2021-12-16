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

    on<MixesLoaded>((event, emit) => _mixesLoaded(event.collection, emit));

    add(MixesLoaded(_collection));
  }

  final IMixesRepository _mixesRepository;
  final String _collection;

  Stream<MixesState> _mapMixesLoadedToState(String collection) async* {}

  void _mixesLoaded(String collection, Emitter<MixesState> emit) async {
    try {
      final mixes = await _mixesRepository.loadMixes(collection);
      emit(MixesLoadSuccessful(mixes));
    } catch (_) {
      emit(MixesLoadFailed());
    }
  }
}
