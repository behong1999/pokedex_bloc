import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_bloc/data/pokemon_info_response.dart';
import 'package:pokedex_bloc/data/pokemon_page_response.dart';
import 'package:pokedex_bloc/data/pokemon_species_response.dart';

//* Fetch Data From API
class PokemonRepository {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<PokemonPageResponse> fetchPokemonPage(int pageIndex) async {
    //* pokemon?limit=100&offset=200

    final queryParameters = {
      'limit': pageIndex == 9 ? '88' : '90',
      'offset': (pageIndex * 90).toString()
    };

    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    print('$pageIndex || ${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Failed To Fetch Data!');
    }

    return PokemonPageResponse.fromJson(json);
  }

  Future<PokemonInfoResponse> getPokemonInfo(int pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$pokemonId');

    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);

      return PokemonInfoResponse.fromJson(json);
    } catch (error) {
      print(error);
    }
  }

  Future<PokemonSpeciesInfoReponse> getPokemonSpeciesInfo(int pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonId');

    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return PokemonSpeciesInfoReponse.fromJson(json);
  }

  Future<int> getPokemonIdFromName(String name) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$name');

    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);

      return PokemonInfoResponse.fromJson(json).id;
    } catch (error) {
      print(error);
    }
  }
}
