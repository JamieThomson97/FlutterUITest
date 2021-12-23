import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:vibration/bloc/audio_controller/audio_controller_bloc.dart';
import 'package:vibration/cubit/search/search_cubit.dart';
import 'package:vibration/model/mix.dart';
import 'package:vibration/model/user.dart';
import 'package:vibration/repository/authentication_repository.dart';
import 'package:vibration/repository/mixes_repository.dart';

class MockAuthenticationRepository implements IAuthenticationRepository {
  MockAuthenticationRepository([this.automaticallyLoggedIn = false]);

  final bool automaticallyLoggedIn;
  @override
  Future<void> logInWithEmailAndPassword({required String email, required String password}) async {
    await Future.delayed(Duration(seconds: 1));
    User newUser = User(
      id: "id",
      email: "jamie.thomson@hey.com",
      name: "Jamie",
      photo: "",
    );
    _userStream.add(newUser);
  }

  StreamController<User> _userStream = new StreamController();

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp({required String email, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  User? _currentUser;

  @override
  // TODO: implement currentUser
  User get currentUser => _currentUser ?? User.empty;

  @override
  Stream<User> get user async* {
    yield* _userStream.stream.map((user) {
      return user;
    });
  }
}

class MockMixes implements IMixesRepository {
  @override
  Future<List<Mix>> loadMixes(String collection) async {
    // await Future.delayed(Duration(seconds: 1));
    return getMockMixes(20, collection);
  }

  static List<Mix> getMockMixes(int number, String collection) {
    List<Mix> mixes = [];
    for (int i = 0; i < number; i++) {
      var mix = Mix.withColors(
        "id$i",
        "name$i",
        "producer$i",
        "event$i",
        "resources/images/album_artwork_${new Random().nextInt(11) + 1}.jpeg",
        DateTime.now(),
        1108,
        "resources/audio/TestAudioFile.mp3",
        MockSong.getSongs(1108, 20),
      );
      mixes.add(mix);
    }
    return mixes;
  }
}

class MockSong {
  static List<Song> getSongs(int songLength, int sections) {
    return List.generate(
      sections,
      (index) => Song(
        artistName: "Artist: ${index + 1}",
        songName: "Song ${index + 1}",
        startSeconds: (songLength / sections * index).floor(),
        endSeconds: (songLength / sections * (index + 1)).floor(),
      ),
    );
  }

  // ListView colorPalette(AudioControllerState audioControllerState) {
  //   return ListView.builder(
  //     itemCount: audioControllerState.mix!.palette.colors.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Container(
  //         height: 50,
  //         color: audioControllerState.mix!.palette.colors.toList()[index],
  //         child: Center(child: Text('Entry $index')),
  //       );
  //     },
  //   );
  // }
}

class MockSearcher implements ISearcher {
  @override
  List<Mix> getMixes(String search) {
    return MockMixes.getMockMixes(10, "search");
  }
}
