import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/bloc/pokemon_details_cubit.dart';
import 'package:pokedex_bloc/const.dart';
import 'package:pokedex_bloc/data/pokemon_repository.dart';

class NavCubit extends Cubit<int> {
  PokemonDetailsCubit pokemonDetailsCubit;

  NavCubit({@required this.pokemonDetailsCubit}) : super(null);

  void showPokemonDetails(int pokemonId) {
    pokemonDetailsCubit.getPokemonDetails(pokemonId);
    emit(pokemonId);
  }

  void searchPokemon(String idOrName) async {
    int pokemonId;
    bool checkNumeric = isNumericUsingRegularExpression(idOrName);

    //* Fetch The Pokemon's Id from Pokemon's Name if The User Enter the Name
    if (!checkNumeric) {
      try {
        pokemonId = await PokemonRepository().getPokemonIdFromName(idOrName);
      } catch (error) {
        emit(-1);
      }
    } else {
      pokemonId = int.parse(idOrName);
    }
    try {
      if (pokemonId > 898 || pokemonId < 1) {
        throw Exception('Invalid ID');
      }
      pokemonDetailsCubit.getPokemonDetails(pokemonId);
      emit(pokemonId);
    } catch (error) {
      emit(-1);
    }
  }

  void popToPokedex() {
    emit(null);
    pokemonDetailsCubit.clearPokemonDetails();
  }
}
