import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/test/mock_classes.dart';

part 'changeable_filter_state.dart';

class ChangeableFilterCubit extends Cubit<ChangeableFilterState> {
  ChangeableFilterCubit(this.filterGetter)
      : super(
          ChangeableFilterInitial(List.empty(), List.empty()),
        ) {
    filterToMixes = filterGetter.getFilteredMixes();
    emit(
      ChangeableFilterChanged(
        filterToMixes.keys.toList(),
        filterToMixes.keys.first,
        filterToMixes[filterToMixes.keys.first]!,
      ),
    );
  }

  final IFilterGetter filterGetter;

  late Map<String, List<Mix>> filterToMixes;

  void filterChanged(String filter) {}
}

abstract class IFilterGetter {
  Map<String, List<Mix>> getFilteredMixes();
}

class MockFilterGetter implements IFilterGetter {
  @override
  Map<String, List<Mix>> getFilteredMixes() {
    return {
      "test 1": MockMixes.getMockMixes(5, "test"),
      "test 2": MockMixes.getMockMixes(5, "test"),
      "test 3": MockMixes.getMockMixes(5, "test"),
    };
  }
}
