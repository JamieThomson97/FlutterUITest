import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/bloc/mixes/mixes_bloc.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/presentation/widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/repository/mixes_repository.dart';

import 'mix_tile.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    required this.title,
    this.isCircle,
  });

  final bool? isCircle;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MixesBloc(MockMixes()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadlineText("Latest releases"),
          BlocBuilder<MixesBloc, MixesState>(
            builder: (context, state) {
              if (state is MixesLoadInProgress) {
                return Text("In progress");
              } else if (state is MixesLoadSuccessful) {
                final mixes = state.mixes;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [...List.generate(mixes.length, (index) => MixTile())],
                  ),
                );
              } else {
                return Text("Failed");
              }
            },
          ),
        ],
      ),
    );
  }
}

class MockMixes implements IMixesRepository {
  @override
  Future<List<Mix>> loadMixes() async {
    await Future.delayed(Duration(seconds: 1));
    var mix = Mix(
      "id",
      "name",
      "producer",
      "event",
      "url",
      DateTime.now(),
      9999,
    );
    List<Mix> mixes = [];
    mixes.add(mix);
    return mixes;
  }
}
