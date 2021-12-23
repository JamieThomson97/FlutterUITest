import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/cubit/search/search_state.dart';
import 'package:vibration/model/mix.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searcher) : super(SearchState(List.empty()));

  final ISearcher searcher;

  void searchTermChanged(String searchTerm) {
    if (searchTerm.length == 0)
      emit(
        SearchState(List.empty()),
      );
    if (searchTerm.length > 2) {
      emit(
        SearchState(searcher.getMixes(searchTerm)),
      );
    }
  }
}

abstract class ISearcher {
  List<Mix> getMixes(String search);
}
