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

  Mix(
    this.id,
    this.name,
    this.producer,
    this.event,
    this.imageUrl,
    this.dateUploaded,
    this.length,
  ) : color = Extensions.GetRandomColor();

  @override
  List<Object> get props => [id];

  @override
  toString() => "Mix - Name:$name. Producer: $producer";
}
