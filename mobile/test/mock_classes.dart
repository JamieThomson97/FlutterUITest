import 'package:vibration/repository/repository_interface.dart';

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
