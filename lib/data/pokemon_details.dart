import 'package:flutter/foundation.dart';

//* This class is used to form 2 API responses into one object
class PokemonDetails {
  final int id;
  final String name;
  final String imageUrl;
  final String backImageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final String description;

  PokemonDetails({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.backImageUrl,
    @required this.types,
    @required this.height,
    @required this.weight,
    @required this.description,
  });
}
