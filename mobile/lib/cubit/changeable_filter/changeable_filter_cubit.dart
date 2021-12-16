import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/test/mock_classes.dart';

part 'changeable_filter_state.dart';

class ChangeableFilterCubit extends Cubit<ChangeableFilterState> {
  ChangeableFilterCubit(this.filterGetter)
      : super(
          ChangeableFilterInitial(List.empty()),
        ) {
    filterToMixes = filterGetter.getFilteredMixes();
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
    return {"test": MockMixes.getMockMixes(5, "test")};
  }
}
