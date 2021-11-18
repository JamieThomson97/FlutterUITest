import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/bloc/app/app_bloc.dart';
import 'package:vibration/presentation/pages/home_page.dart';
import 'package:vibration/presentation/pages/now_playing_page.dart';
import 'package:vibration/presentation/pages/search_page.dart';
import 'package:vibration/presentation/widgets/now_playing.dart';
import 'package:vibration/repository/authentication_repository.dart';
import 'package:vibration/test/mock_classes.dart';
import 'package:vibration/theme.dart';
import 'package:vibration/cubit/screens/screens_cubit.dart';
import 'package:flutter/material.dart';

import 'bloc/audio_controller/audio_controller_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = MockAuthenticationRepository(false);
  runApp(MyApp(authenticationRepository));
}

class MyApp extends StatelessWidget {
  const MyApp(
    this._authenticationRepository, {
    Key? key,
  }) : super(key: key);

  final IAuthenticationRepository _authenticationRepository;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AppBloc>(
              create: (_) => AppBloc(
                authenticationRepository: _authenticationRepository,
              ),
            ),
            BlocProvider<AudioControllerBloc>(
              create: (_) => AudioControllerBloc(),
            )
          ],
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return MaterialApp(
                routes: {
                  '/now_playing': (context) => BlocProvider.value(
                        value: BlocProvider.of<AudioControllerBloc>(context),
                        child: NowPlayingPage(),
                      ),
                },
                theme: theme,
                home: HomeWidget(),
              );
            },
          )),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomeWidgetState extends State<HomeWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 2: Lightbulb',
      style: optionStyle,
    ),
    SearchPage(),
    Text(
      'Index 4: Library',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget theDefault() => _widgetOptions.elementAt(_selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ScreensCubit(),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocListener<ScreensCubit, ScreensState>(
                  child: _widgetOptions.elementAt(_selectedIndex),
                  listener: (context, state) {
                    _navigate(state.route);
                  },
                ),
              ),
            ),
            NowPlaying(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_rounded),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  static Map<String, Function> routeToWidget = {
    "now_playing": (context) => BlocProvider.value(
          value: BlocProvider.of<AudioControllerBloc>(context),
          child: NowPlayingPage(),
        ),
  };

  void _navigate(String route) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) {
          return routeToWidget[route]!(context);
        },
      ),
    );
  }
}
