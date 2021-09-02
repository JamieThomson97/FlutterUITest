import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibration/bloc/mixes/mixes_bloc.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/presentation/widgets/misc_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vibration/test/mock_classes.dart';

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
      create: (context) => MixesBloc(MockMixes(), title),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadlineText(title),
            BlocBuilder<MixesBloc, MixesState>(
              builder: (context, state) {
                if (state is MixesLoadInProgress) {
                  return Text("In progress");
                } else if (state is MixesLoadSuccessful) {
                  final mixes = state.mixes;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(mixes.length * 2, (index) {
                          if (index % 2 != 0) {
                            return SizedBox(width: 5);
                          }
                          return MixTile(mixes[(index ~/ 2)]);
                        })
                      ],
                    ),
                  );
                } else {
                  return Text("Failed");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
