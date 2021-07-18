import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:vibration/bloc/app/app_bloc.dart';
import 'package:vibration/bloc/mixes/bloc/mixes_bloc.dart';
import 'package:vibration/cubit/login/login_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:vibration/model/mix.dart';

import 'mock_classes.dart';

void main() {
  group("LoginCubit", () {
    late MixesBloc mixesBloc;

    setUp(() {
      mixesBloc = MixesBloc(MockMixes());
    });

    blocTest<MixesBloc, MixesState>(
      'Test Mixes Successful',
      build: () => mixesBloc,
      act: (bloc) {
        bloc.add(MixesLoaded());
      },
      expect: () {
        List<Mix> mixes = [MockMixes.mockMix];
        return <MixesState>[MixesLoadSuccessful(mixes)];
      },
    );
  });
}
