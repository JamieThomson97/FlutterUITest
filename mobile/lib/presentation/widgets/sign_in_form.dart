import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:vibration/cubit/login/login_cubit.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
      child: Form(
        // autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            _EmailInputField(),
            const SizedBox(height: 20),
            _PasswordInputField(),
            const SizedBox(height: 60),
            _LoginFormButton(
              null,
              "Log In",
            ),
            // Center(
            //   child: Row(
            //     children: [
            //       _LoginFormButton(
            //         null,
            //         "Log In",
            //         () => context.read<LoginCubit>().logInWithCredentials(),
            //       ),
            //       // const Spacer(),
            //       // _LoginFormButton(
            //       //   null,
            //       //   "Register",
            //       //   () => context.read<LoginCubit>().logInWithCredentials(),
            //       // ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // bool _enableButtons(BuildContext context) {
  //   return context.select((SignInFormBloc bloc) => bloc.state.emailAddress.value.fold((l) => false, (r) => true)) &&
  //       context.select((SignInFormBloc bloc) => bloc.state.password.value.fold((l) => false, (r) => true));
  // }
}

class _PasswordInputField extends StatelessWidget {
  const _PasswordInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: const InputDecoration(labelText: 'password'),
          onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
        );
      },
    );
  }
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(labelText: 'email'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
        );
      },
    );
  }
}

class _LoginFormButton extends StatelessWidget {
  const _LoginFormButton(Key? key, this._buttonText) : super(key: key);

  final String _buttonText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (prev, current) {
        return LoginState.buttonStateChanged(prev, current);
      },
      builder: (context, state) {
        return SizedBox(
          height: 55,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: state.inputIsValid()
                  ? MaterialStateProperty.all(Colors.blue)
                  : MaterialStateProperty.all(Colors.grey[600]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  side: BorderSide(
                    color: state.inputIsValid() ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
            onPressed: state.inputIsValid() ? () => _onPressed(context) : null,
            child: Center(
              child: Text(
                state.status == FormzStatus.submissionInProgress ? "Please wait" : _buttonText,
                style: TextStyle(
                  fontSize: 22,
                  color: state.inputIsValid() ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    context.read<LoginCubit>().logInWithCredentials();
  }
}
