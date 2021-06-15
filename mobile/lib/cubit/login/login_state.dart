part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  static bool buttonStateChanged(LoginState prev, LoginState current) {
    return prev.email != current.email || prev.password != current.password;
  }

  // static bool enabledButtons(LoginState prev, LoginState current) {}

  final Email email;
  final Password password;
  final FormzStatus status;

  bool inputIsValid() => true; // status == FormzStatus.valid;

  @override
  List<Object> get props => [email, password, status];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
