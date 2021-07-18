import 'package:flutter_test/flutter_test.dart';
import 'package:vibration/cubit/login/login_cubit.dart';

import 'mock_classes.dart';

void main() {
  group("LoginCubit", () {
    late LoginCubit loginCubit;

    setUp(() {
      loginCubit = LoginCubit(MockAuthenticationRepository());
    });

    loginCubit = LoginCubit(MockAuthenticationRepository());

    test("fuckknows", () {
      loginCubit.emailChanged("jamie.thomson@hey.com");
      loginCubit.passwordChanged("v3ryStrongp4");
      expect(loginCubit.state.inputIsValid(), true);
    });
    // blocTest<LoginCubit, LoginState>('dsd.',
    //     build: () => loginCubit,
    //     act: (bloc) {
    //       bloc.emailChanged("jamie.thomson@hey.com");
    //       //bloc.passwordChanged("Va4l1D!P4ssword");
    //     },
    //     expect: () {});
  });
}
