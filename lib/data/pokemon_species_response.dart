import 'package:flutter/foundation.dart';

class PokemonSpeciesInfoReponse {
  final String description;

  PokemonSpeciesInfoReponse({@required this.description});

  factory PokemonSpeciesInfoReponse.fromJson(Map<String, dynamic> json) {
    print(json['flavor_text_entries'][0]['flavor_text']);
    return PokemonSpeciesInfoReponse(
        description: json['flavor_text_entries'][0]['flavor_text']);
  }
}
