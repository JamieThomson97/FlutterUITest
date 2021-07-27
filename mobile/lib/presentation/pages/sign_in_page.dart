import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/bloc/app/app_bloc.dart';
import 'package:vibration/cubit/login/login_cubit.dart';
import 'package:vibration/presentation/widgets/sign_in_form.dart';
import 'package:vibration/repository/authentication_repository.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state.status == AppStatus.authenticated) {
            Navigator.of(context).pushNamed('/home');
          }
        },
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<IAuthenticationRepository>()),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const Spacer(flex: 4),
                const Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(flex: 4),
                Center(
                  child: SignInForm(),
                ),
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () => {
                            FirebaseFirestore.instance.collection('test').add({'name': 'CuntyLloyd'})
                          },
                          child: Text(
                            "Forgot your password?",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () => {
                            FirebaseFirestore.instance.collection('test').add({'timestamp': 'JamieThomson'})
                          },
                          child: Text(
                            "Sign up",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
