import 'package:equatable/equatable.dart';
import 'package:vibration/model/mix.dart';

class SearchState extends Equatable {
  SearchState(this.mixes);

  @override
  List<Object> get props => [mixes];

  final List<Mix> mixes;
}
