import 'package:flutter/foundation.dart';

/*   
?CALL https://pokeapi.co/api/v2/pokemon?limit=100&offset=200
count:1118
next:"https://pokeapi.co/api/v2/pokemon?offset=300&limit=100"
previous:"https://pokeapi.co/api/v2/pokemon?offset=100&limit=100"
results: [  {name:"unown"
  url:"https:/ /pokeapi.co/api/v2/pokemon/201/"}
  {name:"wobbuffet"
  url:"https://pokeapi.co/api/v2/pokemon/202/"}
  *      [0] [1]     [2]  [3][4]   [5]   [6]
  ...
]
 */

class PokemonListing {
  final int id;
  final String name;

  PokemonListing({@required this.id, @required this.name});

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

  factory PokemonListing.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final name = json['name'];
    final id = int.parse(url.split('/')[6]);

    return PokemonListing(id: id, name: name);
  }
}

class PokemonPageResponse {
  final List<PokemonListing> pokemonListings;
  final bool nextPageLoadable;

  PokemonPageResponse({
    @required this.pokemonListings,
    @required this.nextPageLoadable,
  });

  factory PokemonPageResponse.fromJson(Map<String, dynamic> json) {
    final nextPageLoadable = json['next'] != null;
    final pokemonListings = (json['results'] as List)
        .map((listingJson) => PokemonListing.fromJson(listingJson))
        .toList();

    return PokemonPageResponse(
      pokemonListings: pokemonListings,
      nextPageLoadable: nextPageLoadable,
    );
  }
}
