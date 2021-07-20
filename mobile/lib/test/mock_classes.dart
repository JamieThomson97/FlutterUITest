import 'package:vibration/model/mix.dart';
import 'package:vibration/model/user.dart';
import 'package:vibration/repository/authentication_repository.dart';
import 'package:vibration/repository/mixes_repository.dart';

class MockAuthenticationRepository implements IAuthenticationRepository {
  MockAuthenticationRepository([this.automaticallyLoggedIn = false]);

  final bool automaticallyLoggedIn;
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

  @override
  // TODO: implement currentUser
  User get currentUser => automaticallyLoggedIn ? User.mockUser : User.empty;

  @override
  // TODO: implement user
  Stream<User> get user async* {
    yield User.empty;
  }
}

class MockMixes implements IMixesRepository {
  @override
  Future<List<Mix>> loadMixes() async {
    await Future.delayed(Duration(seconds: 1));
    return getMockMixes(20);
  }

  static List<Mix> getMockMixes(int number) {
    List<Mix> mixes = [];
    for (int i = 0; i < number; i++) {
      var mix = Mix(
        "id$i",
        "name$i",
        "producer$i",
        "event$i",
        "url$i",
        DateTime.now(),
        9999 + i,
      );
      mixes.add(mix);
    }
    return mixes;
  }
}
