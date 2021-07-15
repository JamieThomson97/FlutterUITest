import 'package:vibration/model/mix.dart';

abstract class IMixesRepository {
  Future<List<Mix>> loadMixes();
}
