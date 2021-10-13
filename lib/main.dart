import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/app_navigator.dart';
import 'package:pokedex_bloc/bloc/nav_cubit.dart';
import 'package:pokedex_bloc/bloc/pokemon_bloc.dart';
import 'package:pokedex_bloc/bloc/pokemon_details_cubit.dart';
import 'package:pokedex_bloc/pokedex_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokemonDetailsCubit = PokemonDetailsCubit();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: Colors.red, accentColor: Colors.redAccent),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PokemonBloc(),
            ),
            BlocProvider(
              create: (context) =>
                  NavCubit(pokemonDetailsCubit: pokemonDetailsCubit),
            ),
            BlocProvider(
              create: (context) => pokemonDetailsCubit,
            )
          ],
          child: AppNavigator(),
        ));
  }
}
