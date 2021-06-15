import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            const SizedBox(height: 70),
            Center(
              child: Row(
                children: [
                  _SignInButton(),
                  const Spacer(),
                  _RegisterButton(),
                ],
              ),
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

class _SignInButton extends StatelessWidget {
  const _SignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (prev, current) => LoginState.buttonStateChanged(prev, current),
      builder: (context, state) {
        return ButtonTheme(
          minWidth: 150,
          height: 60,
          child: TextButton(
            onPressed: state.inputIsValid() ? () => context.read<LoginCubit>().logInWithCredentials() : null,
            child: const Text(
              "Sign in",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (prev, current) {
        return LoginState.buttonStateChanged(prev, current);
      },
      builder: (context, state) {
        return ButtonTheme(
          minWidth: 150,
          height: 60,
          child: TextButton(
            onPressed: state.inputIsValid() ? () => context.read<LoginCubit>().logInWithCredentials() : null,
            child: const Text(
              "Register",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        );
      },
    );
  }
}
