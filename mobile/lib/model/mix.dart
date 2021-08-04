import 'package:equatable/equatable.dart';

class Mix extends Equatable {
  final String id;
  final String name;
  final String producer;
  final String event;
  final String imageUrl;
  final DateTime dateUploaded;
  final int length;

  Mix(
    this.id,
    this.name,
    this.producer,
    this.event,
    this.imageUrl,
    this.dateUploaded,
    this.length,
  );

  @override
  List<Object> get props => [id];

  @override
  toString() => "Mix - Name:$name. Producer: $producer";
}
