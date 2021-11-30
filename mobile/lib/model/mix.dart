import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'extensions.dart';

class Mix extends Equatable {
  final String id;
  final String name;
  final String producer;
  final String event;
  final String imageUrl;
  final DateTime dateUploaded;
  final int length;
  final String path;
  final List<Song> songs;
  late Color color;

  Mix(
    this.id,
    this.name,
    this.producer,
    this.event,
    this.imageUrl,
    this.dateUploaded,
    this.length,
    this.path,
    this.songs,
  );

  Mix.withColors(this.id, this.name, this.producer, this.event, this.imageUrl, this.dateUploaded, this.length,
      this.path, this.songs) {
    PaletteGenerator.fromImageProvider(AssetImage(imageUrl)).then((value) {
      this.color = value.colors.toList()[7];
    });
  }

  @override
  List<Object> get props => [id];

  @override
  toString() => "Mix - Name:$name. Producer: $producer";
}

class Song {
  final String artistName;
  final String songName;
  final int startSeconds;
  final int endSeconds;

  Song({
    required this.artistName,
    required this.songName,
    required this.startSeconds,
    required this.endSeconds,
  });
}
