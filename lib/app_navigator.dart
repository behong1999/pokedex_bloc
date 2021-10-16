import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/bloc/nav_cubit.dart';
import 'package:pokedex_bloc/views/error_view.dart';
import 'package:pokedex_bloc/views/pokedex_view.dart';
import 'package:pokedex_bloc/views/pokemon_details_view.dart';
import 'package:pokedex_bloc/widgets/warning.dart';

class AppNavigator extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(builder: (context, pkmId) {
      //* Prevent From Exiting the App When Pressing the Back Button of the Device
      return WillPopScope(
        onWillPop: (() async => !await _navigatorKey.currentState.maybePop()),
        child: Navigator(
          key: _navigatorKey,

          //* Stacking each of these pages on top of each other based on the logic specified
          pages: [
            MaterialPage(child: PokedexView()),
            if (pkmId != null && pkmId != -1)
              MaterialPage(child: PokemonDetailsView()),
            // if (pkmId == -1) MaterialPage(child: ErrorView())
          ],
          onPopPage: (route, result) {
            BlocProvider.of<NavCubit>(context).popToPokedex();
            return route.didPop(result);
          },
        ),
      );
    });
  }
}
