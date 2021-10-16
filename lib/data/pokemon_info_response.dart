import 'package:flutter/foundation.dart';

class PokemonInfoResponse {
  final int id;
  final String name;
  final String imageUrl;
  final String backImageUrl;
  final List<String> types;
  final int height;
  final int weight;

  PokemonInfoResponse({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.backImageUrl,
    @required this.types,
    @required this.height,
    @required this.weight,
  });

  factory PokemonInfoResponse.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
        .map((type) => type['type']['name'] as String)
        .toList();

    return PokemonInfoResponse(
        id: json['id'],
        name: json['name'],
        imageUrl: json['sprites']['front_default'],
        backImageUrl: json['sprites']['back_default'],
        types: types,
        height: json['height'],
        weight: json['weight']);
  }
}