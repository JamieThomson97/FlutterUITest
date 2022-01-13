part of 'login_form_cubit.dart';

class LoginFormState extends Equatable {
  LoginFormState(this.isInputValid, this.email, this.password);

  final bool isInputValid;
  final String email;
  final String password;

  @override
  List<Object?> get props => [isInputValid];
}
