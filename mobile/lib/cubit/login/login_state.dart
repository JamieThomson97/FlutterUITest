part of 'login_cubit.dart';

enum LoginStateEnum {
  // initial,
  noUser,
  inProgress,
  loginFailed,
  userLoggedIn,
}

abstract class LoginState extends Equatable {
  final LoginStateEnum status;

  LoginState(this.status);
  @override
  List<Object?> get props => [];
}

class LoginStateNoUser extends LoginState {
  LoginStateNoUser() : super(LoginStateEnum.noUser);
}

class LoginStateInProgress extends LoginState {
  LoginStateInProgress() : super(LoginStateEnum.inProgress);
}

class LoginStateLoginFailed extends LoginState {
  LoginStateLoginFailed() : super(LoginStateEnum.loginFailed);
}

class LoginStateUserLoggedIn extends LoginState {
  final String userName;

  // this will just become a user object
  LoginStateUserLoggedIn(this.userName) : super(LoginStateEnum.userLoggedIn);
}
