import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/bloc/app/app_bloc.dart';
import 'package:vibration/presentation/pages/home_page.dart';
import 'package:vibration/presentation/pages/sign_in_page.dart';
import 'package:vibration/repository/authentication_repository.dart';
import 'package:vibration/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(MyApp(authenticationRepository: authenticationRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })   : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
          create: (_) => AppBloc(
                authenticationRepository: _authenticationRepository,
              ),
          child: MaterialApp(
            home: HomePage(),
            theme: theme,
          )),
    );
  }
}
