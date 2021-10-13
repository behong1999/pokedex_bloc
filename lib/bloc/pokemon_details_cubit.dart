import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:pokedex_bloc/data/pokemon_details.dart';
import 'package:pokedex_bloc/data/pokemon_info_response.dart';
import 'package:pokedex_bloc/data/pokemon_repository.dart';
import 'package:pokedex_bloc/data/pokemon_species_response.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetails> {
  final _pokemonRepository = PokemonRepository();

  PokemonDetailsCubit() : super(null);

  void getPokemonDetails(int pokemonId) async {
    //? Future.wait starts both asynchronous functions at the same time
    final response = await Future.wait([
      _pokemonRepository.getPokemonInfo(pokemonId),
      _pokemonRepository.getPokemonSpeciesInfo(pokemonId),
    ]);

    final pokemonInfo = response[0] as PokemonInfoResponse;
    final pokemonSpecies = response[1] as PokemonSpeciesInfoReponse;

    emit(PokemonDetails(
      id: pokemonId,
      name: pokemonInfo.name,
      imageUrl: pokemonInfo.imageUrl,
      backImageUrl: pokemonInfo.backImageUrl,
      types: pokemonInfo.types,
      height: pokemonInfo.height,
      weight: pokemonInfo.weight,
      description: pokemonSpecies.description,
    ));
  }

  //* Used to Clear the Pokemon Details STATE
  void clearPokemonDetails() => emit(null);
}
