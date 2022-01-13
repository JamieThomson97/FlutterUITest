part of 'login_form_cubit.dart';

class LoginFormState extends Equatable {
  LoginFormState(this.isInputValid, this.email, this.password);

  final bool isInputValid;
  final String? email;
  final String? password;

  @override
  List<Object?> get props => [isInputValid, email, password];

  LoginFormState copyWith(String? email, String? password) {
    var actualEmail = email ?? this.email;
    var actualPassword = password ?? this.password;
    var isInputValid = _areFieldsValid(actualEmail, actualPassword);

    var newState = LoginFormState(
      isInputValid,
      actualEmail,
      actualPassword,
    );
    return newState;
  }

  bool _areFieldsValid(String? email, String? password) {
    if (Extensions.isNullOrEmpty(email) || Extensions.isNullOrEmpty(password)) return false;

    bool isEmailValid = email!.length > 5 && email.contains('@') && email.contains('.');
    bool isPasswordValid = password!.length > 3; // obvs would have more

    return isEmailValid && isPasswordValid;
  }
}
