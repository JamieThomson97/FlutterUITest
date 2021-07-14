import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationRepository {
  Future<void> signUp({
    required String email,
    required String password,
  });
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> logOut();
}