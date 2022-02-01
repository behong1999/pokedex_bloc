import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_bloc/bloc/nav_cubit.dart';

void main() {
  group('NavCubit Test', () {
    NavCubit navCubit;

    setUp(() {
      navCubit = NavCubit(pokemonDetailsCubit: null);
    });

    tearDown(() {
      navCubit.close();
    });

    test('The Initial State for the NavCubit is NavCubit', () {});
  });
}
