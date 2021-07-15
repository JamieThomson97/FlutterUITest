import 'package:vibration/model/mix.dart';
import 'package:vibration/repository/authentication_repository.dart';
import 'package:vibration/repository/mixes_repository.dart';

class MockAuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<void> logInWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement logInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}

class MockMixes implements IMixesRepository {
  @override
  Future<List<Mix>> loadMixes() async {
    await Future.delayed(Duration(seconds: 1));
    var mix = Mix(
      "id",
      "name",
      "producer",
      "event",
      "url",
      DateTime.now(),
      9999,
    );
    List<Mix> mixes = [];
    mixes.add(mix);
    return mixes;
  }
}
