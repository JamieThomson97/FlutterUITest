import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
      child: Form(
        // autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(decoration: const InputDecoration(labelText: 'email'), onChanged: null),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'password'),
              onChanged: (value) {},
            ),
            const SizedBox(height: 70),
            Center(
              child: Row(
                children: [
                  ButtonTheme(
                    minWidth: 150,
                    height: 60,
                    child: FlatButton(
                      onPressed: null,
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  ButtonTheme(
                    minWidth: 150,
                    height: 60,
                    child: FlatButton(
                      onPressed: null,
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
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
