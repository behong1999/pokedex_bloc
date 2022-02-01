import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokedex_bloc/data/pokemon_page_response.dart';
import 'package:pokedex_bloc/data/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRepository = PokemonRepository();

  PokemonBloc() : super(PokemonInitial());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is PokemonPageRequest) {
      yield PokemonPageLoading();

      try {
        final pokemonPageResponse =
            await _pokemonRepository.fetchPokemonPage(event.page);
        yield PokemonPageLoadSuccess(
            pokemonListings: pokemonPageResponse.pokemonListings,
            nextPageLoadable: pokemonPageResponse.nextPageLoadable);
      } catch (error) {
        yield PokemonPageLoadFailed();
      }
    }
  }
}
