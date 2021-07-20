import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/bloc/app/app_bloc.dart';
import 'package:vibration/presentation/pages/home_page.dart';
import 'package:vibration/presentation/pages/now_playing_page.dart';
import 'package:vibration/presentation/pages/sign_in_page.dart';
import 'package:vibration/repository/authentication_repository.dart';
import 'package:vibration/test/mock_classes.dart';
import 'package:vibration/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = MockAuthenticationRepository(false);
  await authenticationRepository.user.first;
  runApp(MyApp(authenticationRepository));
}

class MyApp extends StatelessWidget {
  const MyApp(
    this._authenticationRepository, {
    Key? key,
  }) : super(key: key);

  final IAuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
          create: (_) => AppBloc(
                authenticationRepository: _authenticationRepository,
              ),
          child: MaterialApp(
            home: BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                return state.user.isEmpty ? SignInPage() : HomePage();
              },
            ),
            theme: theme,
          )),
    );
  }
}
