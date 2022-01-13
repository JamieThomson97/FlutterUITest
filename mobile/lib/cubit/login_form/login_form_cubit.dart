import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/model/extensions.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(LoginFormState(false, null, null));

  void emailChanged(String email) {
    emit(
      state.copyWith(
        email,
        null,
      ),
    );
  }

  void passwordChanged(String password) {
    emit(
      state.copyWith(
        null,
        password,
      ),
    );
  }
}
