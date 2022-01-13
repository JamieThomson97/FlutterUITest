import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/cubit/login/login_cubit.dart';
import 'package:vibration/cubit/login_form/login_form_cubit.dart';

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
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: const InputDecoration(labelText: 'password'),
          onChanged: (password) => context.read<LoginFormCubit>().passwordChanged(password),
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
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(labelText: 'email'),
          onChanged: (email) => context.read<LoginFormCubit>().emailChanged(email),
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
    return BlocBuilder<LoginFormCubit, LoginFormState>(
      // buildWhen: (prev, current) {
      //   return LoginState.buttonStateChanged(prev, current);
      // },
      builder: (context, state) {
        return BlocBuilder<LoginCubit, LoginState>(
          builder: (loginContext, loginState) {
            return SizedBox(
              height: 55,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: state.isInputValid
                      ? MaterialStateProperty.all(Colors.blue)
                      : MaterialStateProperty.all(Colors.grey[600]),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      side: BorderSide(
                        color: state.isInputValid ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ),
                onPressed: state.isInputValid ? () => _onPressed(context) : null,
                child: Center(
                  child: Text(
                    loginState.status == LoginStateEnum.inProgress ? "Please wait" : _buttonText,
                    style: TextStyle(
                      fontSize: 22,
                      color: state.isInputValid ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onPressed(BuildContext context) {
    var formState = context.read<LoginFormState>();
    context.read<LoginCubit>().logInWithCredentials(formState.email, formState.password);
  }
}
