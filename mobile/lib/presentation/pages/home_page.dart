import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/bloc/app/app_bloc.dart';
import 'package:vibration/cubit/now_playing_scroll/now_playing_cubit.dart';
import 'package:vibration/model/user.dart';
import 'package:vibration/presentation/widgets/carousel.dart';
import 'package:vibration/presentation/widgets/discover_carousel.dart';
import 'package:vibration/presentation/widgets/misc_widgets.dart';
import 'package:vibration/presentation/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
        children: <Widget>[
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return TitleBar(userName: state.user.name.toString());
            },
          ),
          ListSpacer(),
          DiscoverCarousel(),
          ListSpacer(),
          Carousel(
            title: "Recently Listened",
          ),
          ListSpacer(),
          Carousel(
            title: "We think you'll like",
          ),
          ListSpacer(),
          Carousel(
            title: "Producers",
            isCircle: true,
          ),
        ],
      ),
    );
  }
}
