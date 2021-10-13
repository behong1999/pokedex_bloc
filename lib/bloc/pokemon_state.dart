part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonPageLoading extends PokemonState {}

class PokemonPageLoadSuccess extends PokemonState {
  final List<PokemonListing> pokemonListings;
  final bool nextPageLoadable;

  PokemonPageLoadSuccess(
      {@required this.pokemonListings, @required this.nextPageLoadable});
}

class PokemonPageLoadFailed extends PokemonState {}
