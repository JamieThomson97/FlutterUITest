import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'extensions.dart';

class Mix extends Equatable {
  final String id;
  final String name;
  final String producer;
  final String event;
  final String imageUrl;
  final DateTime dateUploaded;
  final int length;
  final Color color;
  final String path;
  final List<Song> songs;

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
  ) : color = Extensions.GetRandomColor();

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
