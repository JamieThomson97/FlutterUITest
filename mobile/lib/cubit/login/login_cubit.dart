import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibration/repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginStateNoUser());

  final IAuthenticationRepository _authenticationRepository;

// I'm deciding that it is the responbility of the Cubit/Bloc to update the state of other blocs. I.e. saving the retrieved user object after logging in here, as opposed to the auth repo doing it.
  Future<void> logInWithCredentials(String email, String password) async {
    emit(LoginStateInProgress());
    try {
      var user = await _authenticationRepository.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        emit(LoginStateUserLoggedIn(user.email!));
      }
      emit(LoginStateLoginFailed());
    } on Exception {
      emit(LoginStateLoginFailed());
    }
  }
}
